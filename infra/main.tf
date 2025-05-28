provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for hosting the static resume site
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

# S3 Bucket policy to allow public access via CloudFront (not direct browser)
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.resume_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontRead"
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.resume_site.arn}/*"
      }
    ]
  })
}

# CloudFront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for autocloudmate"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.resume_site.bucket_regional_domain_name
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100" # Use cheapest CloudFront locations

  viewer_certificate {
    cloudfront_default_certificate = true  # Use default CloudFront cert (HTTPS)
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "autocloudmate-cdn"
  }
}

# CloudFront Cache Invalidation (triggers on every change)
resource "null_resource" "invalidate_cloudfront" {
  provisioner "local-exec" {
    command = <<EOT
      aws cloudfront create-invalidation \
        --distribution-id ${aws_cloudfront_distribution.cdn.id} \
        --paths "/*"
    EOT
  }

  triggers = {
    always_run = "${timestamp()}" # Forces it to run on every `apply`
  }
}
