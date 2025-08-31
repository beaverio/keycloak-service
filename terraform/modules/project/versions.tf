terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.7"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}
