resource "aws_devopsguru_resource_collection" "resource_collection" {
  type = "AWS_TAGS"
  tags {
    app_boundary_key = "devops-guru-rds"
    tag_values       = ["true"]
  }
}