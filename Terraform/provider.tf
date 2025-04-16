terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
  config_path = "C:/Users/Vaishnavi Shinde/.kube/config"
}


# If you want to automatically configure the Kubernetes provider using the aws_eks data source,
# you can avoid the need for a kubeconfig file entirely by passing the required parameters
# (API server endpoint, CA certificate, and token) directly to the kubernetes provider.

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.camp.cluster_endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.camp.cluster_ca_certificate)
#   token                  = data.aws_eks_cluster_auth.camp.token
# }

# data "aws_eks_cluster" "camp" {
#   name = "camp-eks-cluster"
# }

# data "aws_eks_cluster_auth" "camp" {
#   name = "camp-eks-cluster"
# }
