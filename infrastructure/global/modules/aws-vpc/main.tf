resource "aws_vpc" "terraform-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.project_name
  }
}

resource "aws_internet_gateway" "terraform-internet-gateway" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = var.project_name
  }
}

resource "aws_route_table" "terraform-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-internet-gateway.id
  }

  tags = {
    Name = "${var.project_name}-public"
  }
}

resource "aws_subnet" "terraform-subnets" {
  for_each = toset(var.availability_zones)

  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.terraform-vpc.cidr_block, 8, index(var.availability_zones, each.key) + 1)
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-public-${index(var.availability_zones, each.key)}"
  }
}

resource "aws_route_table_association" "terraform-route-table-association" {
  for_each = aws_subnet.terraform-subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.terraform-route-table.id
}
