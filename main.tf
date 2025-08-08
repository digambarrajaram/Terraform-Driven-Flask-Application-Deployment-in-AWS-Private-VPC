
resource "aws_vpc" "VPC_for_Python_Flask_App" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
  Name = var.vpc_name }
}

resource "aws_subnet" "Flask_App_Subnet" {
  vpc_id                  = aws_vpc.VPC_for_Python_Flask_App.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "Flask_IGW" {
  vpc_id = aws_vpc.VPC_for_Python_Flask_App.id

  tags = {
    Name = var.IGW_Name
  }
}

resource "aws_route_table" "Flask_route_table" {
  vpc_id = aws_vpc.VPC_for_Python_Flask_App.id

  route {
    cidr_block = var.RT_cidr_block
    gateway_id = aws_internet_gateway.Flask_IGW.id
  }

  tags = {
    Name = var.RT_Name
  }
}

resource "aws_route_table_association" "Flask_route_table_association" {
  subnet_id      = aws_subnet.Flask_App_Subnet.id
  route_table_id = aws_route_table.Flask_route_table.id
}


resource "aws_security_group" "Flask_SG" {
  description = "Allow HTTP, SSH inbound and all outbound traffic"
  vpc_id      = aws_vpc.VPC_for_Python_Flask_App.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.SG_cidr_block
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.SG_cidr_block
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.SG_cidr_block
  }

  tags = {
    Name = var.SG_Name
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name           # Replace with your desired key name
  public_key = file(var.pub_key_path) # Replace with the path to your public key file
}

resource "aws_instance" "Development_Instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.Flask_SG.id]
  subnet_id              = aws_subnet.Flask_App_Subnet.id
  availability_zone      = var.availability_zone

  # Define EBS root volume
  root_block_device {
    volume_size           = 30    # Size in GiB
    volume_type           = "gp3" # General Purpose SSD (gp2, gp3, io1, etc.)
    delete_on_termination = true  # Delete EBS volume when instance is terminated
  }

  tags = {
    Name = var.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip", # Example package installation
      "cd /home/ubuntu",
      "sudo apt install -y python3-flask",
      "sudo bash -c 'nohup python3 /home/ubuntu/app.py > /home/ubuntu/app.log 2>&1 &'",
      "curl -s --retry 5 --retry-connrefused http://localhost || echo 'App failed to start'",
    ]
  }
}













/*
resource "aws_vpc_security_group_ingress_rule" "Flask_ingress_rule_tcp" {
  security_group_id = aws_security_group.Flask_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "Flask_ingress_rule_ssh" {
  security_group_id = aws_security_group.Flask_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "Flask_egress_rule_tcp" {
  security_group_id = aws_security_group.Flask_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "Flask_egress_rule_ssh" {
  security_group_id = aws_security_group.Flask_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

variable "key_name" {
  description = "Key_name"
  default = "manage-node-1"
}

variable "public_key" {
  description = "Public Key path"
  default = file("~/.ssh/id_rsa.pub")
}
*/

