variable "kc_base_url" {
  type        = string
  description = "Keycloak Instance URL"
}

variable "kc_admin_username" {
  type        = string
  description = "Keycloak Admin Username"
  sensitive   = true
}

variable "kc_admin_password" {
  type        = string
  description = "Keycloak Admin Password"
  sensitive   = true
}

variable "test_user_password" {
  type        = string
  description = "Non-Prod User's Password"
  sensitive   = true
}