variable "project_name" {
  type        = string
  description = "Name of the Render project"
}

variable "render_api_key" {
  type        = string
  description = "Render API key"
  sensitive   = true
}

variable "render_owner_id" {
  type        = string
  description = "Render owner ID (team or user ID)"
}
