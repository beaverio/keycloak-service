resource "local_file" "hello" {
  filename = var.output_path
  content  = <<-EOT
  Hello, ${var.name}!

  This file was created by Terraform at: ${timestamp()}
  Project: ${var.project}
  EOT
}