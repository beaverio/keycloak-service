data "terraform_remote_state" "project" {
  backend = "s3"
  config = {
    bucket = "mochafund-terraform"
    key    = "keycloak-service/infrastructure/project/terraform.tfstate"
    region = "us-east-1"
  }
}
