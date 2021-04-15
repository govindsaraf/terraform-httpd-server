terraform {
    required_version = ">= 0.12.4"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "nexus_instance" {
    ami                         = "ami-0533f2ba8a1995cf9" # Amaxon Linux 2 AMI from eu-west-2 region
    count                       = 1
    instance_type               = "t3.medium"
    key_name                    = "kigo"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["sg-0d4fc4deb81e56565"] # ensure this Security Group has port 8081 opened
    user_data                   = templatefile("${path.cwd}/instance-bootstrap.tmpl", {})

    tags = {
        Name            = "Http-Instance"
        ProvisionedBy   = "Terraform"
    }
}

