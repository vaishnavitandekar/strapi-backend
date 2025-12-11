provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow Strapi and SSH"

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "strapi" {
  ami           = "ami-068c0051b15cdb816"    
  instance_type = "t3.micro"
  key_name      = "vaishnavi-strapi-key"     

  user_data = file("${path.module}/user_data.sh")

  vpc_security_group_ids = [
    aws_security_group.strapi_sg.id
  ]

  tags = {
    Name = "Strapi-Server"
  }
}

output "public_ip" {
  value = aws_instance.strapi.public_ip
}
