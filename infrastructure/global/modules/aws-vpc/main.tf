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
  count = "2"

  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.terraform-vpc.cidr_block, 8, count.index + 1)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-public-${count.index}"
  }
}

resource "aws_route_table_association" "terraform-route-table-association" {
  count = length(aws_subnet.terraform-subnets)

  subnet_id      = aws_subnet.terraform-subnets.*.id[count.index]
  route_table_id = aws_route_table.terraform-route-table.id
}
