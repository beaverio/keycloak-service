resource "render_project" "keycloak_service" {
  lifecycle {
    prevent_destroy = true
  }

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