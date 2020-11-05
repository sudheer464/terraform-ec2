#default
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

#ami to build from
variable "aws_amis" {
  type = "map"
  default = {
    us-east-1 = "<AMi_ID>"
  }
}

resource "aws_security_group" "jenkins-sg" {
    name = "Jenkins_SG"
    description = "Jenkins Security Group"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = "8080"
        to_port = "8080"
        cidr_blocks = ["<ip address>"]
        protocol = "tcp"
    }

    ingress {
        from_port = "22"
        to_port = "22"
        cidr_blocks = ["<ip address>"]
        protocol = "tcp"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
  tags {
    Name = "jenkins-sg"
  }
}

#jenkins-build server instance
resource "aws_instance" "jenkins-build" {
    count = "${var.jenkins-build_count}"
    ami = "${var.aws_amis}"
    instance_type = "${var.instance_type}"
    key_name= "${var.key_name}"
    subnet_id= "${var.subnet_id}"
    security_groups = [ "${var.security_groups}" ]

  tags {
      Name = "${format("jenkins-build-%03d", count.index + 1)}"
    }    
}

