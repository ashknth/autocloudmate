provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for your static resume website
resource "aws_s3_bucket" "resume_site" {
  bucket = "autocloudmate"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "autocloudmate"
    Environment = "ResumeSite"
  }
}

# Origin Access Identity (OAI) to restrict S3 access to CloudFront only
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for autocloudmate"
}

# Bucket Policy to allow read access to CloudFront via OAI
resource "aws_s3_bucket_policy" "allow_cf_read" {
  bucket = aws_s3_bucket.resume_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.resume_site.arn}/*"
      }
    ]
  })
}

# CloudFront Cache Invalidation (triggered on every change)
resource "null_resource" "invalidate_cloudfront" {
  provisioner "local-exec" {
    command = <<EOT
      aws cloudfront create-invalidation \
        --distribution-id E37CM87UA02ZMU \
        --paths "/*"
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
