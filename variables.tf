variable "allow-everything" {
   type = string
   default = "sg-06b1b57b365846051"
}
variable "zone_id" {
    default = "Z04170512YJ0J7OLQX180"
}
variable "domain_name" {
  default = "lingaiah.online"
}
variable "k8s_instance" {
   default = {
        instance_type  = "t3.micro"
   }
}

# variable "public_subnet_id" {
#     type = string
#     default = "subnet-0ea509ad4cba242d7" #update it right one.
# }

