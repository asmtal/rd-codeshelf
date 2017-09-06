variable "id" {}
variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "auth" {
  key_name      = "${var.key_name}"
  public_key    = "${file(var.public_key_path)}"
}

resource "aws_instance" "as_web_servers" {
  count         = "${var.count_instances}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.auth.id}"
  tags {
    Name = "as-web-servers-${count.index}"
  }
  availability_zone = "${element(var.azs,count.index)}"
}

resource "aws_ebs_volume" "isv" {
  count             = "${length(var.ebs_volumes) * var.count_instances}"
  type              = "${var.ebs_volume_type}"
  availability_zone = "${element(var.azs,count.index)}"
  size              = "${var.ebs_size}"
}

resource "aws_volume_attachment" "ebs_att" {
  count = "${length(var.ebs_volumes)  * var.count_instances }"
  device_name = "${format("%s", lower("/dev/${var.ebs_volumes[count.index  % length(var.ebs_volumes) ]}"))}"
  volume_id   = "${element(aws_ebs_volume.isv.*.id, count.index)}"
  instance_id = "${element(aws_instance.as_web_servers.*.id, count.index / length(var.ebs_volumes))}"
}


output "key" {
  value = "${var.access_key}"
}

output "pass" {
  value = "${var.secret_key}"
}



