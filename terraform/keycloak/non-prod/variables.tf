variable "kc_user_password" {
  type        = string
  description = "Keycloak Admin-CLI User Password"
  sensitive   = true
}

variable "kc_url" {
  type        = string
  description = "Keycloak Instance URL"
}