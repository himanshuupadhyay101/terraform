terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_iam_user" "example" {
  count =1
  name = "Himanshu"
}
data "aws_iam_policy_document" "example" {
  statement {
    actions = [
      "ec2:Describe*"]
    resources = [
      "*"]
  }
}
