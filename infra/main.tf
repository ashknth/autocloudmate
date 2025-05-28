provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  default = "autocloudmate"
}

variable "distribution_id" {
  default = "E37CM87UA02ZMU"
}

# CloudFront cache invalidation on every Terraform apply
resource "null_resource" "invalidate_cloudfront" {
  provisioner "local-exec" {
    command = <<EOT
      aws cloudfront create-invalidation \
        --distribution-id ${var.distribution_id} \
        --paths "/*"
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
