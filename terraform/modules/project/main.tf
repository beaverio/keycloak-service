resource "render_project" "keycloak_service" {
  name = var.project_name
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

