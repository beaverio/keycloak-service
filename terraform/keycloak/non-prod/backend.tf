terraform {
  backend "s3" {
    bucket = "mochafund-terraform"
    key    = "keycloak-service/keycloak/non-prod/terraform.tfstate"
    region = "us-east-1"
  }
}