variable "aws-region" {
    type= string
    default= "us-east-1"
}
variable "start-preffix"{
    type= string
    default = "devops"
}
variable "application" {
    type= string
    default= "acklen-challenge"
}
variable "environment" {
    type= string
    default= "sandbox"
}
variable "working-machine-ip"{
    type=string
    default="0.0.0.0/0"
}
variable "nodejs-key-name"{
    type=string
    default="nodejs"
}
variable "nodejs-private-key-path"{
    type=string
    default="ssh-keys/${var.nodejs-key-name}"
}
variable "nodejs-public-key-path"{
    type=string
    default="ssh-keys/${var.nodejs-key-name}.pub"
}
variable "ansible-key-name"{
    type=string
    default="ansible"
}
variable "ansible-private-key-path"{
    type=string
    default="ssh-keys/${var.ansible-key-name}"
}
variable "ansible-public-key-path"{
    type=string
    default="ssh-keys/${var.ansible-key-name}.pub"
}