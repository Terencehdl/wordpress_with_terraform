

resource "aws_security_group" "sg_wordpress_lb" {
  name   = "sg_wordpress_lb"
  vpc_id = var.vpc_id 

  ingress {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Datascientest-alb"
    }

}

resource "aws_security_group" "sg_wordpress" {

  vpc_id = var.vpc_id
  name = "sg_wordpress"
  tags = {
    Name = "sg_wordpress"
  }
  
}

resource "aws_security_group_rule" "allow_all" {
    type              = "ingress"
  cidr_blocks       = ["10.0.128.0/20","10.0.144.0/20"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_wordpress.id
  
}

resource "aws_security_group_rule" "outbound_allow_all" {
    type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_wordpress.id
  
}

resource "aws_security_group" "sg_bastion" {
   name = "sg_bastion"
   description = "Security group for bastion host"
   vpc_id = var.vpc_id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


