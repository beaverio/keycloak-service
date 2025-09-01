terraform {
  backend "s3" {
    bucket = "beaver-terraform-states"
    key    = "keycloak-service/infrastructure/non-prod/terraform.tfstate"
    region = "us-east-1"
  }
}
