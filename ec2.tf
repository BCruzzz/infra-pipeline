resource "aws_instance" "meu-website-server" {
  ami                    = "ami-0341d95f75f311023" # Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type          = "t3.micro"
  key_name               = "meu-website-key"
  vpc_security_group_ids = [aws_security_group.meu-website-sg.id]
  iam_instance_profile = "EC2-ECR-Role"
  user_data = file("user_data.sh")

  tags = {
    Name        = "meu-website-server"
    Provisioned = "Terraform"
    Cliente     = "Bruno"
  }
}

## Security Group

resource "aws_security_group" "meu-website-sg" {
  name   = "meu-website-sg"
  vpc_id = "vpc-0f0c2a0760f3a39f3"

  tags = {
    Name        = "meu-website-sg"
    Provisioned = "Terraform"
    Cliente     = "Bruno"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.meu-website-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.meu-website-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.meu-website-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.meu-website-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}



