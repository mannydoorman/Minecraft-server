variable "aws_region"      { default = "us-east-1" }
variable "ami_id"          { default = "ami-084568db4383264d4" }  # Ubuntu AMI in your region
variable "instance_type"   { default = "t2.small" }
variable "public_key_path" { default = "~/.ssh/id_rsa.pub" }
