#Either add 1 by 1 all the security group rule or use dynamic for each 

# I)Add all the ports one by one with same syntax
# resource "aws_security_group_rule" "allow_nodes_to_cluster_http" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
#   source_security_group_id = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
# }



# II) Dynamic for each
resource "aws_security_group_rule" "allow_nodes_to_cluster" {
  for_each = toset(var.allowed_ports)

  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
}

#application is running on port 3000 that is y theis for range of 3000-10000
resource "aws_security_group_rule" "allow_port_range" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 10000
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
  
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
