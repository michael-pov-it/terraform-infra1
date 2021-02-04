# Retrieve the AZ where we want to create network resources
# This must be in the region selected on the AWS provider.
data "aws_availability_zone" "az1" {
  name = "eu-central-1a"
}
data "aws_availability_zone" "az2" {
  name = "eu-central-1b"
}