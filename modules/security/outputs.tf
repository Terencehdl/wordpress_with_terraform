output "sg_bastion_id" {
  value = aws_security_group.sg_bastion.id
}

output "sg_wordpress_id" {
  value = aws_security_group.sg_wordpress.id
}

output "sg_wordpress_lb_id" {
  value = aws_security_group.sg_wordpress_lb.id
}

