# Event sources are configured at the account level.
# To avoid persistent differences, this resource should be defined only once.
resource "aws_devopsguru_event_sources_config" "event_sources_config" {
  event_sources {
    amazon_code_guru_profiler {
      status = "ENABLED"
    }
  }
}

resource "aws_devopsguru_resource_collection" "resource_collection" {
  type = "AWS_TAGS"
  tags {
    app_boundary_key = "devops-guru-rds"
    tag_values       = ["aurora-mysql-read", "aurora-mysql-write"]
  }
}