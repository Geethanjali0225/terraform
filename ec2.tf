# File: ec2.tf

# Create security group for EC2 instances
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define inbound rules as needed
  # ...

  tags = {
    Name = "web_sg"
  }
}

# Launch EC2 instance in the public subnet
resource "aws_instance" "public_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Specify your desired AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key_pair.key_name
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
              EOF

  tags = {
    Name = "public_instance"
  }
}

# Launch EC2 instance in the private subnet
resource "aws_instance" "private_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Specify your desired AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key_pair.key_name
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
                #!/bin/bash
                # Any additional setup for the private instance
              EOF

  tags = {
    Name = "private_instance"
  }
}

