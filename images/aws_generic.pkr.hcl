variable "ssh_user" {}
variable "ssh_key_path" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "baseplay" {
    type                       = string
    default                    = "basic"
}

source "amazon-ebs" "singlenode" {
    access_key                 = "${var.aws_access_key}"
    secret_key                 = "${var.aws_secret_key}"
    region                     = "${var.aws_region}"
    source_ami                 = "ami-0b7fd7bc9c6fb1c78"

    # build specifics
    ami_name                   = "packer_${var.baseplay}"
    instance_type              = "t2.small"
    ssh_username               = "${var.ssh_user}"
    ssh_interface              = "public_ip"
    ssh_private_key_file       = "${var.ssh_key_path}"
    communicator               = "ssh"
    ssh_keypair_name           = "OperetoBox"
    launch_block_device_mappings {
        device_name            = "/dev/sda1"
        volume_size            =  20
        volume_type            = "gp2"
        delete_on_termination  = true
    }
}

build {

  provisioner "shell" {
    expect_disconnect = false
    inline                     = [
        "sudo apt-get clean",
        "sudo rm -rf /var/lib/apt/lists/partial",
        "sudo apt-get update -q",
        "sudo apt-get upgrade -qy",
        "sudo apt-get install -qy",
        "sudo ln -s /usr/bin/python3 /usr/bin/python",
        "sudo python --version",
    ]
  }

  provisioner "ansible" {
    playbook_file              = "../ansible/${var.baseplay}.yml"
  }

  sources = [
    "sources.amazon-ebs.singlenode"
  ]

}
