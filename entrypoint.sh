#!/usr/bin/env bash
set -euo pipefail

REALM_FILE="/opt/keycloak/data/import/realm.json"

if [[ ! -s "$REALM_FILE" ]]; then
  echo "ERROR: realm file not found or empty: $REALM_FILE" >&2
  exit 1
fi

echo "==> Importing realm from ${REALM_FILE}"
/opt/keycloak/bin/kc.sh import --file "${REALM_FILE}" --override=true

echo "==> Starting Keycloak..."
exec /opt/keycloak/bin/kc.sh start --optimized