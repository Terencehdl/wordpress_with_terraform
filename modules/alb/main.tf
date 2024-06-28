
// load balancer pour les réseaux publics
resource "aws_lb" "lb_evaluation" {
  name               = "evaluation-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.evaluation_public_subnet_a_id,var.evaluation_public_subnet_b_id]
  security_groups    = [var.sg_wordpress_lb_id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.lb_evaluation.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.evaluation_vms.arn}"
  }
}

resource "aws_lb_target_group" "evaluation_vms" {
  name     = "tf-evaluation-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

## Joindre l' instance A à la zone de disponibilté A au groupe cible
resource "aws_lb_target_group_attachment" "evaluation_tg_attachment" {
  target_group_arn = "${aws_lb_target_group.evaluation_vms.arn}"
  target_id =   var.wordpress_instance_a_id

  port             = 80
}

## Joindre l' instance B à la zone de disponibilté B au groupe cible
resource "aws_lb_target_group_attachment" "datascientestb_tg_attachment" {
  target_group_arn = "${aws_lb_target_group.evaluation_vms.arn}"
  target_id =  var.wordpress_instance_b_id
  port             = 80
  }
