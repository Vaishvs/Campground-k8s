output "private_subnet_ids" {
  value = [aws_subnet.workernode_private_subnet1.id, aws_subnet.workernode_private_subnet2.id]
}


output "eks_cluster_security_group" {
  value = aws_eks_cluster.my_cluster.vpc_config[0].cluster_security_group_id
}


output "existing_igw_id" {
  value = data.aws_internet_gateway.default.id
}

output "first_two_public_subnets" {
  value = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
}
