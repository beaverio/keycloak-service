resource "keycloak_realm" "non_prod" {
  realm        = "non-prod"
  display_name = "Non-Production"
  enabled      = true

  lifecycle {
    prevent_destroy = true
  }
}