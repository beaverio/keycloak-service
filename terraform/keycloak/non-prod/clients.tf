resource "keycloak_openid_client" "auth_gateway" {
  realm_id = keycloak_realm.non_prod.id
  client_id = "auth-gateway"
  name = "auth-gateway"
  enabled = true
  access_type = "CONFIDENTIAL"
  standard_flow_enabled = true
  full_scope_allowed = true

  valid_redirect_uris = [
    "http://localhost:8000/login/oauth2/code/auth-gateway"
  ]
  web_origins = [
    "http://localhost:8000"
  ]
}

resource "keycloak_openid_client" "identity_service" {
  realm_id = keycloak_realm.non_prod.id
  client_id = "identity-service"
  name = "identity-service"
  enabled = true
  access_type = "CONFIDENTIAL"
  service_accounts_enabled = true
  full_scope_allowed = true
}