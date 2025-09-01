data "terraform_remote_state" "project" {
  backend = "s3"
  config = {
    bucket = "beaver-terraform-states"
    key    = "keycloak-service/infrastructure/project/terraform.tfstate"
    region = "us-east-1"
  }
}
