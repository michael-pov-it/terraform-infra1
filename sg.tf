# Security Group for webserver 1
resource "aws_security_group" "it-syndicate-sg" {
    name        = "Open 80 and 443 ports for itsyndicate1 ws"
    description = "Open ports 80 and 443 for internet access over HTTP and HTTPS"
    vpc_id = aws_vpc.main.id

    dynamic "ingress" {
      for_each = ["80", "443"]
      content {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Incoming traffic over HTTP"
        from_port = ingress.value
        protocol = "tcp"
        to_port = ingress.value
      }
    }
    egress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Outgoing acess everywhere"
      from_port = 0
      protocol = -1
      to_port = 0
    }
    tags = {
        Name = "IT-Syndicate Security Group"
    }
}