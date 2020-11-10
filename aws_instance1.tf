terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "terraformexample" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"


tags = {
    Name = "terraform-example"
  }
}
}

