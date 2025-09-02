variable "render_api_key" {
  type        = string
  description = "Render API key"
  sensitive   = true
}

variable "render_owner_id" {
  type        = string
  description = "Render owner ID (team or user ID)"
  sensitive = true
}

variable "keycloak_admin_password" {
  type        = string
  description = "keycloak_admin_password"
  sensitive = true
}

variable "kc_db_url" {
  type        = string
  description = "kc_db_url"
  sensitive = true
}

variable "kc_db_username" {
  type        = string
  description = "kc_db_username"
  sensitive = true
}

variable "kc_db_password" {
  type        = string
  description = "kc_db_password"
  sensitive = true
}