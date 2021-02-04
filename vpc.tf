/***
VPC 
***/
# Create a VPC for the region associated with the AZ
resource "aws_vpc" "main" {
  cidr_block     = cidrsubnet("10.0.0.0/16", 4, var.region_number[data.aws_availability_zone.az1.region])
  instance_tenancy = "default"
  tags           = {
    Name = "VPC for itsyndicate ws"
  }
}
# Create subnet 1 for the AZ within the regional VPC
resource "aws_subnet" "subnet1" {
  vpc_id         = aws_vpc.main.id
  cidr_block     = cidrsubnet(aws_vpc.main.cidr_block, 4, var.az_number[data.aws_availability_zone.az1.name_suffix])
  availability_zone = "eu-central-1a"
  tags = {
    Name = "Subnet 1"
  }
}
# Create subnet 2 for the AZ within the regional VPC
resource "aws_subnet" "subnet2" {
  vpc_id         = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, var.az_number[data.aws_availability_zone.az2.name_suffix])
  availability_zone = "eu-central-1b"
  tags = {
    Name = "Subnet 2"
  }
}
# Internet GW for VPC
resource "aws_internet_gateway" "vpc1gw" {
  vpc_id         = aws_vpc.main.id
}
# Route table
resource "aws_route_table" "public1" {
  vpc_id         = aws_vpc.main.id

  route {
    cidr_block   = "0.0.0.0/0"
    gateway_id   = aws_internet_gateway.vpc1gw.id
  }
}
# Route tables assotiations
resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public1.id
}
resource "aws_route_table_association" "public-subnet2" {  
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public1.id
}