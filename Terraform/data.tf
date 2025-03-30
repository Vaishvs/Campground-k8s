

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "availability-zone"
    values = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  }
}


data "aws_subnet" "my_subnet" {

  id = tolist(data.aws_subnets.public_subnets.ids)[0]

  }

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}