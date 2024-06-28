

resource "aws_launch_configuration" "wordpress_launch_config" {
  name          = "wordpress-launch-config"
  image_id      = "ami-030c654bdf22c1b7e"

  instance_type = "t2.micro"

}

resource "aws_autoscaling_group" "wordpress_asg" {
  name                 = "wordpress-asg"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  vpc_zone_identifier  = [var.evaluation_public_subnet_a_id,var.evaluation_public_subnet_b_id]
  launch_configuration = aws_launch_configuration.wordpress_launch_config.name
}

