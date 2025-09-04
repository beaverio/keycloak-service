resource "render_postgres" "keycloak_service_db_np" {
  lifecycle {
    prevent_destroy = true
  }

  name           = "keycloak-service-db-np"
  plan           = "free"
  region         = "ohio"
  version        = "17"
  database_name  = "keycloakservicedb"
  database_user  = "admin"
  environment_id = data.terraform_remote_state.project.outputs.non_production_environment_id
}