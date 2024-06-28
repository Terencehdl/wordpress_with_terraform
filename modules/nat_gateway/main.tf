# module "vpc" {
#   source = "../vpc"
# }

# resource "aws_eip" "nat_eip_a" {
#    vpc = true
# }

# resource "aws_eip" "nat_eip_b" {
#    vpc = true
# }

# resource "aws_nat_gateway" "nat_public_a" {
#   subnet_id = module.vpc.evaluation_public_subnet_a_id
#   allocation_id = aws_eip.nat_eip_a.id
  
#   depends_on = [ aws_eip.nat_eip_a ]

#   tags = {
#     Name = "NatPublicA"
#   }
# }

# resource "aws_nat_gateway" "nat_public_b" {
#   subnet_id = module.vpc.evaluation_public_subnet_b_id
#   allocation_id = aws_eip.nat_eip_b.id

#   depends_on = [ aws_eip.nat_eip_b ]

#     tags = {
#     Name = "NatPublicB"
#   }
# }