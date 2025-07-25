
resource "aws_security_group" "instance_sg" {
  name        = "allow_ssh_and_app"
  description = "Allow SSH and app port"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
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

  tags = {
    Name = "instance-sg"
  }
}

resource "aws_instance" "web1" {
  ami                         = "ami-053b12d3152c0cc71" # Ubuntu 22.04 (Mumbai)
  instance_type               = "t3a.micro"
  subnet_id                   = aws_subnet.public_1.id
  key_name                    = "EC2_SSH_KEY"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              usermod -aG docker ubuntu
              systemctl start docker
              systemctl enable docker
              docker run -d -p 3000:3000 adongy/hostname-docker
              EOF

  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "web2" {
  ami                         = "ami-053b12d3152c0cc71"
  instance_type               = "t3a.micro"
  subnet_id                   = aws_subnet.public_2.id
  key_name                    = "EC2_SSH_KEY"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              usermod -aG docker ubuntu
              systemctl start docker
              systemctl enable docker
              docker run -d -p 3000:3000 adongy/hostname-docker
              EOF

  tags = {
    Name = "web-server-2"
  }
}
