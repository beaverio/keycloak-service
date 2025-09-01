resource "render_postgres" "keycloak_service_db_np" {
  name           = "keycloak-service-db-np"
  plan           = "free"
  region         = "ohio"
  version        = "17"
  database_name  = "keycloakservicedb"
  database_user  = "admin"
  environment_id = data.terraform_remote_state.project.outputs.non_production_environment_id
  ip_allow_list = [
    {
      cidr_block  = "0.0.0.0/0"
      description = "Allow all traffic"
    }
  ]
}