terraform {
  backend "s3" {
    bucket         = "terra-ec2-form"
    key            = "w10/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "locktable"
  }
}