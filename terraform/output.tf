output "ec2_public_ips" {
  description = "Adresses IP publiques des instances EC2"
  value       = aws_instance.ec2[*].public_ip
}

output "s3_bucket_name" {
  description = "Nom du bucket S3"
  value       = aws_s3_bucket.s3_bucket.bucket
}
