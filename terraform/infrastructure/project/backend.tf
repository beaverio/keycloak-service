terraform {
  backend "s3" {
    bucket = "mochafund-terraform"
    key    = "keycloak-service/infrastructure/project/terraform.tfstate"
    region = "us-east-1"
  }
}