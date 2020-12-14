output "amazon-linux-2-server-ami-id"{
    value = data.aws_ami.amazon-linux-2-server-ami.id
}

output "ubuntu-server-ami-id"{
    value = data.aws_ami.ubuntu-server-ami.id
}