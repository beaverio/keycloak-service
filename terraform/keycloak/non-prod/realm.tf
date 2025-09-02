resource "keycloak_realm" "non_prod" {
  lifecycle {
    prevent_destroy = true
  }

  realm        = "non-prod"
  display_name = "Non-Production"
  enabled      = true

  access_code_lifespan        = "900s" // 15 min
  client_session_idle_timeout = "604800s" // 7 days
  client_session_max_lifespan = "2592000s" // 30 days
  sso_session_idle_timeout    = "604800s" // 7 days
  sso_session_max_lifespan    = "2592000s" // 30 days
  revoke_refresh_token        = true
  refresh_token_max_reuse     = 0
}