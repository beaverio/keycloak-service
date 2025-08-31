terraform {
  backend "s3" {
    bucket  = "beaver-terraform-states"
    key     = "keycloak-service/global/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform-nonprod"
  }
}