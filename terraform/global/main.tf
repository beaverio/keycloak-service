module "project" {
  source = "../modules/project"

  project_name    = "keycloak-service"
  render_api_key  = var.render_api_key
  render_owner_id = var.render_owner_id
}