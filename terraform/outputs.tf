output "file_path" {
  value       = local_file.hello.filename
  description = "Where the file was written"
}

output "preview" {
  value       = local_file.hello.content
  description = "A preview of the file content"
}