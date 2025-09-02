terraform {
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.4.0"
    }
  }
}

provider "keycloak" {
  realm         = "non-prod"
  client_id     = "terraform"
  client_secret = var.terraform_client_secret
  url           = var.kc_base_url
}