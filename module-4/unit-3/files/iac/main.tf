# Configure the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.1"
    }
  }

  required_version = "1.14.0"
}


# Resource: AWS S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket = "billing-service-raw-data-2025-iac-test"

  tags = {
    Name = "BillingServiceData"
  }
}

# Resource: AWS S3 Bucket Ownership
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  # !!SECURITY MISCONFIGURATION!!
  # This allows objects to be created in the bucket by
  # EXTERNAL users
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Resource: AWS S3 Bucket Public Access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  # !!CRITICAL SECURITY MISCONFIGURATION!!
  # These settings allow the bucket to be publicly exposed
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
