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
  admin-server
  api-gateway
  config-server
  customers-service
  discovery-server
  vets-service
  visits-service
)

# Processus de compilation, build et push
for service in "${SERVICES[@]}"; do
  echo "🔧 Compilation de $service..."
  cd spring-petclinic-$service || exit
  mvn clean install

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
