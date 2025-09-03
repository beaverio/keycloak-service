terraform {
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
  }
}

provider "keycloak" {
  url       = var.kc_base_url
  username  = var.kc_admin_username
  password  = var.kc_admin_password
  client_id = "admin-cli"
}