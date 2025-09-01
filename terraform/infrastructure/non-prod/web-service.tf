resource "render_web_service" "keycloak_service_np" {
  name           = "keycloak-service-np"
  plan           = "starter"
  region         = "ohio"
  environment_id = data.terraform_remote_state.global.outputs.non_production_environment_id

  runtime_source = {
    docker = {
      branch   = "main"
      repo_url = "https://github.com/beaverio/keycloak-service"
    }
  }

  env_vars = {
    "KEYCLOAK_ADMIN"           = { value = "admin" }
    "KEYCLOAK_ADMIN_PASSWORD"  = { value = var.keycloak_admin_password }
    "KC_DB"                    = { value = "postgres" }
    "KC_DB_URL"                = { value = var.kc_db_url }
    "KC_DB_USERNAME"           = { value = render_postgres.keycloak_service_db_np.database_user }
    "KC_DB_PASSWORD"           = { value = render_postgres.keycloak_service_db_np.connection_info.password }
    "KC_HOSTNAME"              = { value = "keycloak-service-np.onrender.com" }
    "KC_PROXY"                 = { value = "edge" }
    "KC_PROXY_HEADERS"         = { value = "xforwarded" }
    "KC_HOSTNAME_STRICT_HTTPS" = { value = "false" }
  }
}
