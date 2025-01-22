variable "aws_region" {
  description = "Région AWS où déployer l'infrastructure"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "Type des instances EC2"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR du subnet"
  type        = string
  default     = "192.168.0.0/24"
}

variable "instance_count" {
  description = "Nombre d'instances EC2"
  type        = number
  default     = 3
}
