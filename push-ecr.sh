#!/bin/bash

# Paramètres ECR mis à jour
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

# Processus de compilation, build et push
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

  echo "🏷️ Tagging de l'image Docker..."
  docker tag $REPO_NAME:$service $ECR_URL:$service

  echo "📤 Push de l'image vers ECR..."
  docker push $ECR_URL:$service

  cd ..
  echo "✅ $service terminé"
  echo "-----------------------------------------"
done

echo "🎉 Toutes les images ont été poussées dans ECR avec succès."
