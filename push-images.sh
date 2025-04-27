#!/bin/bash

# Définition du registre local
REGISTRY="registry.dev.svc.cluster.local:5000"

# Liste des services à tagger et push
SERVICES=(
  api-gateway
  customers-service
  visits-service
  vets-service
  config-server
  discovery-server
)

# Préfixe généré automatiquement par Docker Compose
PREFIX="projetpetclinicdockercompose_"

echo "📦 Début du tag & push des images vers $REGISTRY"
echo "🔍 Recherche d'images locales correspondantes..."

for SERVICE in "${SERVICES[@]}"; do
  LOCAL_IMAGE="${PREFIX}${SERVICE}"
  TARGET_IMAGE="${REGISTRY}/${SERVICE}"

  if docker image inspect $LOCAL_IMAGE > /dev/null 2>&1; then
    echo "🔄 Traitement de : $LOCAL_IMAGE ➜ $TARGET_IMAGE"
    docker tag $LOCAL_IMAGE $TARGET_IMAGE
    docker push $TARGET_IMAGE

    if [ $? -eq 0 ]; then
      echo "✅ $SERVICE : push réussi"
    else
      echo "❌ $SERVICE : erreur lors du push"
    fi
  else
    echo "⚠️  Image $LOCAL_IMAGE introuvable, elle n’a peut-être pas été buildée"
  fi
done

echo "🎯 Fin du processus."
