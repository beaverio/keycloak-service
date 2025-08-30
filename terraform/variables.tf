variable "name" {
  description = "Your name"
  type        = string
  default     = "Connor"
}

variable "project" {
  description = "Project label"
  type        = string
  default     = "keycloak-learning"
}

variable "output_path" {
  description = "Where to write the file"
  type        = string
  default     = "./hello.txt"
}
