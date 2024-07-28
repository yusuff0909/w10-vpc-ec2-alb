terraform {
  backend "s3" {
    bucket         = "hdhdhdjjdkdkd" #replace with yours
    key            = "w10/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hhdhddjdjdjd" # replace with yours
  }
}