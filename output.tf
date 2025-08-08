output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.VPC_for_Python_Flask_App.id
}

output "subnet_id" {
  description = "Subnet ID"
  value = aws_subnet.Flask_App_Subnet.id
}

output "route_table_id" {
  description = "Route Table ID"
  value = aws_route_table.Flask_route_table.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value = aws_internet_gateway.Flask_IGW.id
}

output "sg_id" {
  description = "Security Group ID"
  value = aws_security_group.Flask_SG.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value = aws_instance.Development_Instance.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.Development_Instance.public_ip
}

output "flask_app_url" {
  description = "URL to access the Flask web app"
  value       = "http://${aws_instance.Development_Instance.public_ip}"
}
