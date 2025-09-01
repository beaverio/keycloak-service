output "project_id" {
  value = render_project.keycloak_service.id
}

output "non_production_environment_id" {
  value = render_project.keycloak_service.environments["non-production"].id
}

output "production_environment_id" {
  value = render_project.keycloak_service.environments["production"].id
}
