data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket  = "beaver-terraform-states"
    key     = "keycloak-service/global/terraform.tfstate"
    region  = "us-east-1"
  }
}
