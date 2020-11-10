terraform {
  backend "s3" {
    bucket = "himanshu10-terraform-bucket"
    key    = "s3bucket.tfstate"
    region = "us-east-2"
  }
}


provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "HimanshuBucket" {
  bucket = "himanshu10-terraform-bucket"
  acl = "private"
  versioning {
    enabled = true
  }
lifecycle_rule {
    enabled = true

    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days = 60
      storage_class = "GLACIER"
    }
  }
 

}
