variable "terraform_client_secret" {
  type        = string
  description = "Keycloak Terraform Client Secret"
  sensitive   = true
}

variable "kc_base_url" {
  type        = string
  description = "Keycloak Instance URL"
}