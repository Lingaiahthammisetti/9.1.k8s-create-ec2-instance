terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "expense-tf-ec2-remote-state"
    key    = "expense-tf-ec2-key"
    region = "us-east-1"
    dynamodb_table = "expense-tf-ec2-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}