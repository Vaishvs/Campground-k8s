variable "cluster_name" {
    type = string
}

variable "node_group_name" {
    type = string
}

# variable "subnet_ids" {
#     description = "List of private subnets for EKS worker nodes"
#     type = list(string)
# }


# variable "allowed_ports" {
#   default = [22, 80, 443, 25, 3000, 6443, 465, 27017] # List of ports to open
# } 

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(string)
  default     = ["22", "80", "25", "443", "8080", "3000", "6443", "465", "27017"]
}

variable "region" {
    type = string
}

variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}
