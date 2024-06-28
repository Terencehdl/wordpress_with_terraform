output "evaluation_public_subnet_a_id" {
  value = aws_subnet.evaluation_public_subnet_a.id
}

output "evaluation_public_subnet_b_id" {
  value = aws_subnet.evaluation_public_subnet_b.id
}

output "wordpress_subnet_a_id" {
  value = aws_subnet.evaluation_wordpress_subnet_a.id
}

output "wordpress_subnet_b_id" {
  value = aws_subnet.evaluation_wordpress_subnet_b.id
}

output "vpc_id" {
  value = aws_vpc.evaluation_vpc.id
}

output "vpc" {
  value = aws_vpc.evaluation_vpc
}
