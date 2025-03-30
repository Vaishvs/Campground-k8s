resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.workernode_private_subnet1.id,
    aws_subnet.workernode_private_subnet2.id
  ]

  scaling_config {
    desired_size = 2   # Ensure desired_size >= min_size
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  ami_type       = "AL2_x86_64" 
  instance_types = ["t2.medium"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

}
