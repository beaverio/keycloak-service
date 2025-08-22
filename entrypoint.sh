#!/usr/bin/env bash
set -euo pipefail

REALM_FILE="/opt/keycloak/data/import/non-prod.json"

echo "==> Importing realm from ${REALM_FILE}"
/opt/keycloak/bin/kc.sh import --file "${REALM_FILE}" --override=true

echo "==> Starting Keycloak..."
exec /opt/keycloak/bin/kc.sh start --optimized