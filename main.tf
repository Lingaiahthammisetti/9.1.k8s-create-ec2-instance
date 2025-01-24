resource "aws_instance" "k8s_workstation" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.k8s_instance.instance_type
    vpc_security_group_ids = [var.allow-everything]
    #user_data = file("workstation.sh")
    #user_data               = file("${path.module}/install_jenkins_master.sh")
    
    
    root_block_device {
    volume_size = 50  # Size of the root volume in GB
    volume_type = "gp2"  # General Purpose SSD (you can change the volume type if needed)
    delete_on_termination = true  # Automatically delete the volume when the instance is terminated
    }
    
    tags = {
        Name = "K8s-Workstation"
    }
}
resource "aws_route53_record" "k8s_r53" {
    zone_id = var.zone_id
    name    = "k8s.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.k8s_workstation.public_ip]
    allow_overwrite = true
}

# module "workstation" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#   name = "workstation"

#   ami           = data.aws_ami.rhel_info.id
#   instance_type = var.k8s_instance.instance_type
#   vpc_security_group_ids = [var.allow-everything]
#   # convert StringList to list and get first element
#   subnet_id = var.public_subnet_id
#   user_data = file("workstation.sh")
#   tags = {
#         Name = "workstation"
#     }
# }










# resource "aws_instance" "expense" {
#     for_each = var.instances
#     ami           = data.aws_ami.rhel_info.id
#     instance_type = each.value
#     vpc_security_group_ids = [var.allow_all]
#     user_data = file("${path.module}/install_${each.key}.sh")

#     tags = {
#         Name = each.key
#     }
# }
# resource "aws_route53_record" "expense_r53" {
#     for_each = aws_instance.expense
#     zone_id = var.zone_id
#     name    = each.key == "frontend"? var.domain_name : "${each.key}.${var.domain_name}" 
#     type    = "A"
#     ttl     = 1
#     records = each.key == "frontend" ? [each.value.public_ip]:[each.value.private_ip]
#     allow_overwrite = true
# }



# resource "aws_instance" "expense_frontend" {
#     ami           = data.aws_ami.rhel_info.id
#     instance_type = var.frontend_instance.instance_type
#     vpc_security_group_ids = [var.allow_all]
#     user_data = file("${path.module}/install_frontend.sh")

#     tags = {
#         Name = "frontend"
#     }
# }
# resource "aws_route53_record" "frontend_r53" {
#     zone_id = var.zone_id
#     name    = "frontend.${var.domain_name}"
#     type    = "A"
#     ttl     = 1
#     records = [aws_instance.expense_frontend.public_ip]
#     allow_overwrite = true
# }

# resource "aws_instance" "expense_backend" {
#     ami           = data.aws_ami.rhel_info.id
#     instance_type = var.backend_instance.instance_type
#     vpc_security_group_ids = [var.allow_all]
#     user_data = file("${path.module}/install_backend.sh")

#     tags = {
#         Name = "backend"
#     }
# }
# resource "aws_route53_record" "backend_r53" {
#     zone_id = var.zone_id
#     name    = "backend.${var.domain_name}"
#     type    = "A"
#     ttl     = 1
#     records = [aws_instance.expense_backend.public_ip]
#     allow_overwrite = true
# }

# resource "aws_instance" "expense_mysql" {
#     ami           = data.aws_ami.rhel_info.id
#     instance_type = var.mysql_instance.instance_type
#     vpc_security_group_ids = [var.allow_all]
#     user_data = file("${path.module}/install_mysql.sh")

#     tags = {
#         Name = "mysql"
#     }
# }
# resource "aws_route53_record" "mysql_r53" {
#     zone_id = var.zone_id
#     name    = "mysql.${var.domain_name}"
#     type    = "A"
#     ttl     = 1
#     records = [aws_instance.expense_mysql.public_ip]
#     allow_overwrite = true
# }