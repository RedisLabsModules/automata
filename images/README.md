# Building images

This directory contains images packer scripts used to create images in cloud environments.

**AWS**

AWS images are built, pre-baking the Opereto user key. As such the following example, will create a new image, from a generic base.

packer build -var 'ssh_user=ubuntu' -var ssh_key_path=/PATH/TO/YOUR/PRIVATE/SSH/KEY  -var aws_region=eu-west-1  -var aws_secret_key=YOUR_AWS_SECRET_KEY -var aws_access_key=YOUR_AWS_ACCESS_KEY aws_generic.pkr.hcl
