module as1_web_servers {
  source = "./as1_web_servers"
  id = "${var.id}"
}

output "ac1_web_servers_received" {
  value = "${module.ac1_web_servers.public_ips}"
}
