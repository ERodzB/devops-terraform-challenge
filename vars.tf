variable "aws-region" {
  type    = string
  default = "us-east-1"
}
variable "application" {
  type    = string
  default = "chatbot"
}
variable "environment" {
  type    = string
  default = "sandbox"
}
variable "working-machine-ip" {
  type    = string
  default = "0.0.0.0/0"
}
variable "nodejs-key-name" {
  type    = string
  default = "nodejs-ec2"
}
variable "ansible-key-name" {
  type    = string
  default = "ansible-ec2"
}
variable "nodejs-private-key-name" {
  type    = string
  default = "nodejs-ec2"
}
variable "ansible-private-key-name" {
  type    = string
  default = "ansible-ec2"
}
variable "nodejs-public-key-name" {
  type    = string
  default = "nodejs-ec2.pub"
}
variable "ansible-public-key-name" {
  type    = string
  default = "ansible-ec2.pub"
}
variable "nodejs-instance-type" {
  type = string
  default = "t2.micro"
}