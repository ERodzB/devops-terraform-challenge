provider "aws" {
  region = var.AWS_PROVIDER["region"]
  //If not using a AWS Cloud9 environment
  //access_key = var.AWS_PROVIDER["access_key"]
  //secret_key = var.AWS_PROVIDER["secret_key"]
}