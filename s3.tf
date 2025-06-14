provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "tf_backend" {
  bucket = "jeee-bum-baaa-bucket"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "fintrack-tf-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
