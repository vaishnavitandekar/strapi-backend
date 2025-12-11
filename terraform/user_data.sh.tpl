#!/bin/bash
sudo yum update -y

sudo yum install docker -y

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ec2-user

docker pull vaishnavi0009/strapi-backend:${docker_image_tag}

docker rm -f strapi || true

docker run -d --name strapi -p 1337:1337 vaishnavi0009/strapi-backend:${docker_image_tag}
