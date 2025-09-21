terraform {
  backend "s3" {
    bucket = "mochafund-terraform"
    key    = "keycloak-service/keycloak/local/terraform.tfstate"
    region = "us-east-1"
  }
}