resource "aws_vpc" "myvpc" {
  cidr_block = var.cider
}
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet13" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "netgate" {
    vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.myvpc.id
    
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.netgate.id
}
}
resource "aws_route_table_association" "rta1" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.subnet1.id

}
resource "aws_route_table_association" "rta13" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.subnet13.id

}
resource "aws_security_group" "sg" {
    name_prefix = "web-sg"
    vpc_id = aws_internet_gateway.netgate.id

    
    ingress {
     description = "HTTP"
     from_port       = 80
     to_port         = 80
     protocol        = "tpc"
     cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
     description = "SSH"
     from_port       = 22
     to_port         = 22
     protocol        = "tpc"
     cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
     from_port        = 0
     to_port          = 0
     protocol         = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
     
  }
}
resource "aws_s3_bucket" "buck" {
    bucket = "yashterraformprojectdemov1"
    
}


resource "aws_instance" "web1" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.subnet1.id
  user_data = file("user1.sh")
}
resource "aws_instance" "web13" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.subnet13.id
    user_data = file("user13.sh")

}
resource "aws_lb" "alb" {
    name = "alb"
    internal = false
    load_balancer_type = "application"

     security_groups = [aws_security_group.sg.id]
     subnets = [aws_subnet.subnet1,aws_subnet.subnet13]
    
  
}
resource "aws_lb_target_group" "t" {
    name = "aat"
    port = 80
    protocol = "http"
    vpc_id = aws_vpc.myvpc.id
    
    health_check {
      path = "/"
      port = "traffic-port"
    }

  
}
resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.t.arn
  target_id        = aws_instance.web1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach13" {
  target_group_arn = aws_lb_target_group.t.arn
  target_id        = aws_instance.web13.id
  port             = 80
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.alb.dns_name
}