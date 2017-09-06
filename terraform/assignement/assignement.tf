variable "access_key" {}
variable "secret_key" {}


module as1_web_servers {
  source = "./as1_web_servers"
  id = "${var.id}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

output "received_key" {
  value = "${module.as1_web_servers.key}"
}

output "recieved_pass" {
  value = "${module.as1_web_servers.pass}"
}

