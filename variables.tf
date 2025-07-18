variable "allow_everything" {
    type = string
    default = "sg-09c7c70bd56f0d58b"
}
variable "zone_id" {
    default ="Z01686671NYDIP6ZJB3D7"
}
variable "domain_name" {
  default = "lingaiah.online"
}
variable "k8s_instance" {
   default = {
        instance_type  = "t3.micro"
   }
}

