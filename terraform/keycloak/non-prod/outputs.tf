locals {
  clients = {
    auth_gateway = {
      client_id     = keycloak_openid_client.auth_gateway.client_id
      client_secret = keycloak_openid_client.auth_gateway.client_secret
    }
    identity_service = {
      client_id     = keycloak_openid_client.identity_service.client_id
      client_secret = keycloak_openid_client.identity_service.client_secret
    }
  }
}

output "secrets" {
  value     = local.clients
  sensitive = true
}