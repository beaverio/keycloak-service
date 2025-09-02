terraform {
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = "terraform-user"
  password  = var.kc_user_password
  url       = var.kc_url
}