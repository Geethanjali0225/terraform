# File: ssh_key.tf

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ssh_key_pair" {
  key_name   = "my_ssh_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

