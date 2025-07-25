resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and port 3000"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web1" {
  ami                         = "ami-0f918f7e67a3323f0"
  instance_type               = "t3a.micro"
  subnet_id                   = aws_subnet.subnet1.id
  key_name                    = "EC2_SSH_KEY"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    docker run -d -p 3000:3000 ghcr.io/eldadfux/hostname-docker
  EOF
}

resource "aws_instance" "web2" {
  ami                         = "ami-0f918f7e67a3323f0"
  instance_type               = "t3a.micro"
  subnet_id                   = aws_subnet.subnet2.id
  key_name                    = "EC2_SSH_KEY"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    docker run -d -p 3000:3000 ghcr.io/eldadfux/hostname-docker
  EOF
}
