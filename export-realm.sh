#!/bin/bash

# Export Keycloak Realm Configuration when making changes in the Keycloak UI.
# Usage: ./export-realm.sh

echo "📤 Exporting current realm configuration..."

# Check if keycloak-service container is running
if ! docker ps | grep -q keycloak-service; then
    echo "❌ Keycloak container (keycloak-service) is not running."
    echo "   Start it through IntelliJ Docker Services first"
    exit 1
fi

# Export realm using Keycloak admin CLI
docker exec keycloak-service /opt/keycloak/bin/kc.sh export \
    --realm non-production \
    --file /tmp/exported-realm.json \
    --users realm_file

# Copy exported file to host
docker cp keycloak-service:/tmp/exported-realm.json ./realm-config/exported-$(date +%Y%m%d-%H%M%S).json

echo "✅ Realm exported to ./realm-config/exported-$(date +%Y%m%d-%H%M%S).json"
echo "   Review the exported file and replace non-production.json if needed"