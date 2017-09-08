
variable "region" {
  default = "ap-southeast-1"
}

variable "count_instances" {
  default = "2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "santb"
}

variable "public_key_path" {
  default = "./santb.pub"
}

variable "ebs_volume_type" {
  default = "gp2"
}

variable "ebs_volumes" {
  type = "list"
  default = ["xvdz"]
}

variable "azs" {
  type = "list"
  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "ebs_size" {
  default = 1
}

variable "amis" {
  type = "map"
  default = {
   "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
    "ap-southeast-1" = "ami-6f198a0c"
  }
}

variable "ansible_repo_location" {
  default = "workspace/rd-codeshelf/ansible/terraform-ansible-playbooks/assignment1"
}

