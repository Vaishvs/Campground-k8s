
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name # You can define the cluster name in variables.tf
  role_arn = aws_iam_role.eks_cluster_role.arn
  # security_group_id = aws_security_group.allow_nodes_to_cluster.id

  vpc_config {
    subnet_ids = [
      aws_subnet.workernode_private_subnet1.id,
      aws_subnet.workernode_private_subnet2.id
    ]
    security_group_ids = [aws_security_group.allow_nodes_to_cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
  ]

}
