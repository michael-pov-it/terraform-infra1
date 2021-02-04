
provider "aws" {}

/***
Web server 1
***/
resource "aws_instance" "itsyndicate1" {
    ami                    = "ami-0502e817a62226e03"
    instance_type = "t3.micro"
    tags                   = {
        Name = "Web Server 1"
        Owner = "Mike Gordievsky"
    }
    vpc_security_group_ids = [aws_security_group.it-syndicate-sg.id]
    user_data = file("./user-data/user_data_ws1.sh")
    subnet_id = aws_subnet.subnet1.id
}
# Elastic IP for Web Server 1*/
resource "aws_eip" "ws1_static_ip" {
    instance = aws_instance.itsyndicate1.id
}

/***
Web server 2
***/
resource "aws_instance" "itsyndicate2" {
    ami           = "ami-0502e817a62226e03"
    instance_type = "t3.micro"
    tags          = {
        Name = "Web Server 2"
        Owner = "Mike Gordievsky"
    }
    vpc_security_group_ids = [aws_security_group.it-syndicate-sg.id]
    user_data = file("./user-data/user_data_ws2.sh")
    subnet_id = aws_subnet.subnet2.id
}
# Elastic IP for Web Server 2
resource "aws_eip" "ws2_static_ip" {
    instance = aws_instance.itsyndicate2.id
}
