#!/bin/bash
# Update system
sudo yum update -y

# Install Docker
sudo yum install docker -y

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add EC2 user to docker group
sudo usermod -aG docker ec2-user

# Pull your latest docker image
docker pull vaishnavi0009/strapi-backend:latest

# Remove old container (if exists)
docker rm -f strapi || true

# Run new Strapi container
docker run -d --name strapi \
  -p 1337:1337 \
  vaishnavi0009/strapi-backend:latest
