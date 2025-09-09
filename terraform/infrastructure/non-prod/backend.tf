terraform {
  backend "s3" {
    bucket = "mochafund-terraform"
    key    = "keycloak-service/infrastructure/non-prod/terraform.tfstate"
    region = "us-east-1"
  }
}
