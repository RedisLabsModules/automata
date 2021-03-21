variable "ssh_user" {}
variable "ssh_key_path" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "baseplay" {}

data "amazon-ami" "ubuntufocal" {
    filters = {
       virtualization-type     = "hvm"
       name                    = "*ubuntu-focal-20.04-amd64-server-*"
       root-device-type        = "ebs-ssd"
    }
    region                     = "${var.aws_region}"
    owners = ["099720109477"]
    most_recent = true
}

source "amazon-ebs" "singlenode" {
    access_key                 = "${var.aws_access_key}"
    secret_key                 = "${var.aws_secret_key}"
    region                     = "${var.aws_region}"

    source_ami                 = data.amazon-ami.ubuntufocal.id

    # build specifics
    ami_name                   = "${var.baseplay}.tests.singlenode"
    instance_type              = "t2.small"
    ssh_username               = "${var.ssh_user}"
    ssh_interface              = "public_ip"
    ssh_private_key_file       = "${var.ssh_key_path}"
#    launch_block_device_mappings = {
#        device_name            = "/dev/sda1"
#        volume_size            =  50
#        volume_type            = "gp2"
#        delete_on_termination  = true
#    }
}

build {

  provisioner "shell"{
    expect_disconnect = false
    inline                      = [
        "sudo apt-get update -q",
        "sudo apt-get upgrade -qy",
        "sudo apt install -y python",
    ]
  }

  provisioner "shell-local" {
    inline            = [
        "cd ../ansible",
        "ansible-playbook -u ${var.ssh_user} --private-key=${var.ssh_key_path} -i {{ipaddress}}, ${var.baseplay}.yml"
    ]
  }

  sources = [
    "sources.amazon-ebs.singlenode"
  ]

}
