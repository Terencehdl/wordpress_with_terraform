data "aws_availability_zones" "available" {}



resource "aws_vpc" "evaluation_vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support


  tags = {
    Name="VpcEvaluationDatascientest"
  }

}

resource "aws_subnet" "evaluation_public_subnet_a" {
   vpc_id = aws_vpc.evaluation_vpc.id
   cidr_block = var.cidr_public_subnet_a
   map_public_ip_on_launch = "true"
   availability_zone       = var.az_public_subnet_a
   
   tags = {
     Name = "public_a"
   }
   depends_on = [ aws_vpc.evaluation_vpc ]

  
}

resource "aws_subnet" "evaluation_public_subnet_b" {
   vpc_id = aws_vpc.evaluation_vpc.id
   cidr_block = var.cidr_public_subnet_b
   map_public_ip_on_launch = "true"
   availability_zone       = var.az_public_subnet_b
   
   tags = {
     Name = "public_b"
   }
   depends_on = [ aws_vpc.evaluation_vpc ]


}

resource "aws_subnet" "evaluation_wordpress_subnet_a" {
   vpc_id = aws_vpc.evaluation_vpc.id
   cidr_block = var.cidr_wordpress_subnet_a
   availability_zone       = var.az_public_subnet_a
   
   tags = {
     Name = "wordpress_a"
   }
   depends_on = [ aws_vpc.evaluation_vpc ]

}

resource "aws_subnet" "evaluation_wordpress_subnet_b" {
   vpc_id = aws_vpc.evaluation_vpc.id
   cidr_block = var.cidr_wordpress_subnet_b
   availability_zone       = var.az_public_subnet_b

   tags = {
     Name = "wordpress_b"
   }
   depends_on = [ aws_vpc.evaluation_vpc ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.evaluation_vpc.id

  tags = {
    Name = "EvaluationIGW"
  }
  
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.evaluation_vpc.id

  tags = {
    Name = "IgwRouteTablePublic"
  }

  depends_on = [ aws_vpc.evaluation_vpc ]
}

resource "aws_route" "route_igw" {
  route_table_id = aws_route_table.igw_route_table.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [ aws_internet_gateway.igw ]
  
}

resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id = aws_subnet.evaluation_public_subnet_a.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id = aws_subnet.evaluation_public_subnet_b.id
  route_table_id = aws_route_table.igw_route_table.id
}


// PRIVATE WORDPRESS SUBNET A


resource "aws_route_table" "route_table_wordpress_subnet_a" {
  vpc_id = aws_vpc.evaluation_vpc.id

  tags = {
    Name = "route_table_wordpress_subnet_a"
  }
  
}

resource "aws_route" "route_wordpress_subnet_a" {
  route_table_id = aws_route_table.route_table_wordpress_subnet_a.id
  gateway_id = aws_nat_gateway.nat_public_a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "route_wordpress_subnet_a_association" {
  route_table_id = aws_route_table.route_table_wordpress_subnet_a.id
  subnet_id = aws_subnet.evaluation_wordpress_subnet_a.id
}

// PRIVATE WORDPRESS SUBNET B 

resource "aws_route_table" "route_table_wordpress_subnet_b" {
  vpc_id = aws_vpc.evaluation_vpc.id

  tags = {
    Name = "route_table_wordpress_subnet_b"
  }
  
}

resource "aws_route" "route_wordpress_subnet_b" {
  route_table_id = aws_route_table.route_table_wordpress_subnet_b.id
  gateway_id = aws_nat_gateway.nat_public_b.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "route_wordpress_subnet_b_association" {
  route_table_id = aws_route_table.route_table_wordpress_subnet_b.id
  subnet_id = aws_subnet.evaluation_wordpress_subnet_b.id
}

resource "aws_eip" "nat_eip_a" {
 

    tags = {
     Name = "EipthA"
   }

}

resource "aws_eip" "nat_eip_b" {
  

   tags = {
     Name = "Eipthb"
   }
}

resource "aws_nat_gateway" "nat_public_a" {
  subnet_id = aws_subnet.evaluation_public_subnet_a.id
  allocation_id = aws_eip.nat_eip_a.id
  
  depends_on = [ aws_eip.nat_eip_a ]

  tags = {
    Name = "NatPublicA"
  }
}

resource "aws_nat_gateway" "nat_public_b" {
  subnet_id = aws_subnet.evaluation_public_subnet_b.id
  allocation_id = aws_eip.nat_eip_b.id

  depends_on = [ aws_eip.nat_eip_b ]

    tags = {
    Name = "NatPublicB"
  }
}
