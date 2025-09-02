# Terraform Service Client
resource "keycloak_openid_client" "terraform" {
  lifecycle {
    prevent_destroy = true
  }

  realm_id                  = keycloak_realm.non_prod.id
  client_id                 = "terraform"
  name                      = "Terraform"
  access_type               = "CONFIDENTIAL"
  client_authenticator_type = "client-secret"
  service_accounts_enabled  = true
}

resource "keycloak_openid_client_service_account_role" "terraform_realm_admin" {
  realm_id                = keycloak_realm.non_prod.id
  service_account_user_id = keycloak_openid_client.terraform.service_account_user_id
  client_id               = data.keycloak_openid_client.realm_mgmt_np.id
  role                    = data.keycloak_role.realm_admin_np.name
}

# Application OIDC Clients
resource "keycloak_openid_client" "auth_gateway" {
  realm_id              = keycloak_realm.non_prod.id
  client_id             = "auth-gateway"
  name                  = "auth-gateway"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  full_scope_allowed    = true

  valid_redirect_uris = [
    "http://localhost:8000/login/oauth2/code/auth-gateway"
  ]
  web_origins = [
    "http://localhost:8000"
  ]
}
resource "keycloak_generic_protocol_mapper" "auth_gateway_userId_mapper" {
  name            = "userId"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  realm_id        = keycloak_realm.non_prod.id
  client_id       = keycloak_openid_client.auth_gateway.id
  config = {
    "user.attribute" : "userId",
    "claim.name" : "userId",
    "jsonType.label" : "String",
    "multivalued" : false,
    "id.token.claim" : true,
    "access.token.claim": true,
    "userinfo.token.claim" : true
    "introspection.token.claim" : true
  }
}

resource "keycloak_openid_client" "identity_service" {
  realm_id                 = keycloak_realm.non_prod.id
  client_id                = "identity-service"
  name                     = "identity-service"
  enabled                  = true
  access_type              = "CONFIDENTIAL"
  service_accounts_enabled = true
  full_scope_allowed       = true
}

data "keycloak_role" "realm_mgmt_role" {
  for_each = toset([
    "view-users",
    "manage-users",
  ])

  realm_id = keycloak_realm.non_prod.id
  client_id = data.keycloak_openid_client.realm_mgmt_np.id
  name     = each.key
}

resource "keycloak_openid_client_service_account_role" "identity_service_role_binding" {
  for_each = data.keycloak_role.realm_mgmt_role

  realm_id                = keycloak_realm.non_prod.id
  service_account_user_id = keycloak_openid_client.identity_service.service_account_user_id
  client_id               = data.keycloak_openid_client.realm_mgmt_np.id
  role                    = each.value.name
}