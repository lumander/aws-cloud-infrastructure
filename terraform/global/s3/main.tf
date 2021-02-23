provider "aws" {
    region = var.region  
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = format("%s-tf-state",substr(uuid(),0,6))

# Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = false
    ignore_changes = [ bucket ]
  }

# Enable versioning so we can see the full revision history of our
# state files
  versioning {
    enabled = false
  }

# Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}