// terraform client secrets
output "terraform_client_id" {
  value = keycloak_openid_client.terraform.client_id
}

output "terraform_client_secret" {
  value     = keycloak_openid_client.terraform.client_secret
  sensitive = true
}

// auth-gateway client secrets
output "auth_gateway_client_id" {
  value = keycloak_openid_client.auth_gateway.client_id
}

output "auth_gateway_client_secret" {
  value     = keycloak_openid_client.auth_gateway.client_secret
  sensitive = true
}

// identity-service client secrets
output "identity_service_client_id" {
  value = keycloak_openid_client.identity_service.client_id
}

output "identity_service_client_secret" {
  value     = keycloak_openid_client.identity_service.client_secret
  sensitive = true
}