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

# Get admin access token using curl from host machine
TOKEN_RESPONSE=$(curl -s -X POST http://localhost:8090/realms/master/protocol/openid-connect/token \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "username=admin" \
    -d "password=admin" \
    -d "grant_type=password" \
    -d "client_id=admin-cli")

# Extract token using sed
TOKEN=$(echo "$TOKEN_RESPONSE" | sed -n 's/.*"access_token":"\([^"]*\)".*/\1/p')

if [ -z "$TOKEN" ]; then
    echo "❌ Failed to get admin access token. Response:"
    echo "$TOKEN_RESPONSE"
    echo ""
    echo "💡 Troubleshooting:"
    echo "   1. Verify Keycloak is running: docker logs keycloak-service"
    echo "   2. Check admin credentials in docker-compose.yml"
    echo "   3. Try accessing admin console manually: http://localhost:8090/admin/"
    echo "   4. Make sure curl is installed on your host machine"
    exit 1
fi

# Export realm using REST API from host machine
EXPORT_FILE="./realm-config/exported-$(date +%Y%m%d-%H%M%S).json"

curl -s -X GET \
    "http://localhost:8090/admin/realms/non-production" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" > "$EXPORT_FILE"

# Check if export was successful
if [ $? -eq 0 ] && [ -s "$EXPORT_FILE" ]; then
    echo "✅ Realm exported to $EXPORT_FILE"
    echo ""
    echo "💡 Usage workflow:"
    echo "   1. Make changes in Keycloak UI at http://localhost:8090/admin/"
    echo "   2. Run this script to export your changes"
    echo "   3. Review the exported file and update non-production.json if satisfied"
    echo "   4. Commit the updated configuration to version control"
else
    echo "❌ Failed to export realm"
    # Clean up empty file if it was created
    rm -f "$EXPORT_FILE" 2>/dev/null
    exit 1
fi
