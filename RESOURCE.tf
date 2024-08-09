# resource.tf

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "project-main-vpc"
  }
}

# Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # Assign public IPs to instances
  tags = {
    Name = "project-main-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "project-main-igw"
  }
}

# Route Table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "project-main-route-table"
  }
}

# Route Table Association
resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Security Group
resource "aws_security_group" "main_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For testing, restrict to your IP later
  }

  # Allow Jenkins
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Tomcat
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Nexus
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SonarQube
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow SonarQube
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-main-sg"
  }
}

# EC2 Instances
resource "aws_instance" "web_instances" {
  count                       = length(var.instance_tags)
  ami                         = var.ami_id
  instance_type               = var.instance_types[count.index]
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.main_subnet.id
  vpc_security_group_ids      = [aws_security_group.main_sg.id]
  associate_public_ip_address = true # Assign public IP
  tags                        = var.instance_tags[count.index]

  # EBS Block device configuration
  root_block_device {
    volume_size = lookup(var.volume_sizes, var.instance_tags[count.index].Name, 8) # Default to 8 GB if not specified
  }
}

# S3 Bucket
resource "aws_s3_bucket" "artifactory_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "project-artifactory"
  }
}

# Output variables
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.main_subnet.id
}

output "security_group_id" {
  value = aws_security_group.main_sg.id
}

output "instance_ids" {
  value = aws_instance.web_instances[*].id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.artifactory_bucket.bucket
}
