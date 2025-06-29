resource "aws_instance" "k8s_workstation" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.k8s_instance.instance_type
    vpc_security_group_ids = [var.allow-everything]
    #user_data = file("workstation.sh")
    #user_data               = file("${path.module}/install_jenkins_master.sh")
    root_block_device {
    volume_size = 100  # Size of the root volume in GB
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
