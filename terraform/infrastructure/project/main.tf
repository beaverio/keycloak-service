resource "render_project" "keycloak_service" {
  name = "keycloak-service"
  environments = {
    "non-production" = {
      name             = "non-production"
      protected_status = "unprotected"
    }
    "production" = {
      name             = "production"
      protected_status = "unprotected"
    }
  }
}