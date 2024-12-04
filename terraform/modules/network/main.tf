resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge(
    tomap({ "Name" = "${var.prefix}-vpc" }),
    var.tags
  )
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    tomap({ "Name" = "${var.prefix}-public-${count.index + 1}" }),
    var.tags
  )
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = merge(
    tomap({ "Name" = "${var.prefix}-private-${count.index + 1}" }),
    var.tags
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    tomap({ "Name" = "${var.prefix}-gw" }),
    var.tags
  )
}

resource "aws_route_table" "public_subnets" {
  count  = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    tomap({ "Name" = "${var.prefix}-gw-route-table-${count.index + 1}" }),
    var.tags
  )

}

resource "aws_route_table_association" "public_subnets_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_subnets[count.index].id
}

resource "aws_eip" "this" {
  count = length(var.public_subnet_cidrs)

  tags = merge(
    tomap({ "Name" = "${var.prefix}-eip-${count.index + 1}" }),
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(
    tomap({ "Name" = "${var.prefix}-nat-${count.index + 1}" }),
    var.tags
  )
}

resource "aws_route_table" "private_subnet" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(
    tomap({ "Name" = "${var.prefix}-private-route-table-${count.index + 1}" }),
    var.tags
  )
}

# Associate the private route table with a private subnet
resource "aws_route_table_association" "private_route_assoc" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_subnet[count.index].id
}