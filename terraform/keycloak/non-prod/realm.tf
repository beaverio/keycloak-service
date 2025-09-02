resource "keycloak_realm" "non_prod" {
  realm        = "non-prod"
  display_name = "Non-Production"
  enabled      = true

  lifecycle {
    prevent_destroy = true
  }

  access_code_lifespan = "900s"
  client_session_idle_timeout = "604800s"
  client_session_max_lifespan = "2592000s"
  sso_session_idle_timeout = "604800s"
  sso_session_max_lifespan = "2592000s"
  revoke_refresh_token = true
  refresh_token_max_reuse = 0
}