resource "aws_instance" "k8s_server_instance" {
    ami           = data.aws_ami.rhel_info.id
    instance_type = var.k8s_instance.instance_type
    vpc_security_group_ids = [var.allow_everything]
    #user_data  = file("workstation.sh")
    #user_data  = file("${path.module}/install_jenkins_master.sh")
    root_block_device {
        encrypted             = false
        volume_type           = "gp3"
        volume_size           = 100
        iops                  = 3000
        throughput            = 60
        delete_on_termination = true
    }
    tags = {
        Name = "K8s-ec2-instance"
    }
}
resource "aws_route53_record" "k8s_r53" {
    zone_id = var.zone_id
    name    = "k8s.${var.domain_name}"
    type    = "A"
    ttl     = 1
    records = [aws_instance.k8s_server_instance.public_ip]
    allow_overwrite = true
}
