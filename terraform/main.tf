# Création du VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc"
  }
}

# Création du subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet"
  }
}

# Création de la gateway Internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet"
  }
}

# Création de la table de routage
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route"
  }
}

# Association de la table de routage au subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "ssh_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SecurityGroupSSHandPing"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "ssh-terra"
  public_key = file("${path.module}/ssh-terra.pub")
}

resource "aws_instance" "ec2" {
  count           = var.instance_count
  ami             = "ami-06e02ae7bdac6b938"
  instance_type   = var.instance_type
  key_name        = aws_key_pair.my_key.key_name
  subnet_id       = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "EC2-${count.index}"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-terraform-bucket-${random_pet.name.id}"

  tags = {
    Name = "Terraform-S3-Bucket"
  }
}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}
