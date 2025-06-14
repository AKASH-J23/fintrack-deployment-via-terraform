terraform {
    backend "s3" {
        bucket         = "jeee-bum-baaa-bucket"
        key            = "terraform.tfstate"
        region         = "ap-south-1"
        dynamodb_table = "fintrack-tf-lock"
        encrypt        = true
    }
}
