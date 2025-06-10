#!/bin/bash
set -e

# Paramètres ECR
AWS_ACCOUNT_ID=116981792309
REGION=eu-west-3
REPO_NAME=petclinic
ECR_URL="$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME"

# Connexion à ECR
echo "🔐 Connexion à ECR ($REGION)..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL

# Liste des services à builder et à push
SERVICES=(
  config-server
  discovery-server
  admin-server
  customers-service
  vets-service
  visits-service
  api-gateway
)

# Processus de compilation, build, comparaison et push
for service in "${SERVICES[@]}"; do
  echo "🔧 Compilation de $service..."
  cd spring-petclinic-$service || exit
  mvn clean install

  JAR_FILE=target/spring-petclinic-$service-3.0.2.jar
  if [ ! -f "$JAR_FILE" ]; then
    echo "❌ Le fichier $JAR_FILE n'existe pas. Échec de la compilation de $service."
    exit 1
  fi

  echo "🐳 Construction de l'image Docker pour $service..."
  docker build -t $REPO_NAME:$service .

  echo "🔍 Récupération du digest local pour $service..."
  LOCAL_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $REPO_NAME:$service | cut -d'@' -f2)

  echo "🔎 Vérification du digest distant pour $service..."
  REMOTE_DIGEST=$(aws ecr batch-get-image \
    --repository-name $REPO_NAME \
    --image-ids imageTag=$service \
    --region $REGION \
    --query 'images[0].imageDigest' \
    --output text 2>/dev/null || echo "none")

  if [[ "$LOCAL_DIGEST" == "$REMOTE_DIGEST" ]]; then
    echo "✅ Aucune modification détectée pour $service, image non repoussée."
  else
    echo "📤 Nouvelle image détectée, push de $service vers ECR..."
    docker tag $REPO_NAME:$service $ECR_URL:$service
    docker push $ECR_URL:$service
  fi

  cd ..
  echo "✅ Traitement terminé pour $service"
  echo "-----------------------------------------"
done

echo "🎉 Toutes les images mises à jour ont été traitées avec succès."
