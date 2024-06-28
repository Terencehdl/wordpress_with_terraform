
data "aws_availability_zones" "available" {
  state = "available"
}



resource "aws_instance" "wordpress_instance_a" {
 
  ami = "ami-030c654bdf22c1b7e"
  instance_type = "t2.micro"
  subnet_id = var.wordpress_subnet_a_id
  vpc_security_group_ids =  [var.sg_wordpress_id]
  availability_zone = element(data.aws_availability_zones.available.names, 0)
  associate_public_ip_address = true
  

  tags = {
    Name = " Wordpress A"
  }
}

resource "aws_instance" "wordpress_instance_b" {

  ami = "ami-030c654bdf22c1b7e"
  instance_type = "t2.micro"
  subnet_id = var.wordpress_subnet_b_id
  vpc_security_group_ids =  [var.sg_wordpress_id]
  availability_zone = element(data.aws_availability_zones.available.names, 1)
  associate_public_ip_address = true
  

  tags = {
    Name = " Wordpress B"
  }
}

# // BASTION HOST

data "aws_ami" "bastion_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]  
  }

  owners = ["amazon"]
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "evaluation_key2"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.bastion_ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.evaluation_public_subnet_a_id
  vpc_security_group_ids = [var.sg_bastion_id]
  key_name               = aws_key_pair.my_key_pair.key_name

  tags = {
    Name        = "Bastion_evaluation"
  }

}