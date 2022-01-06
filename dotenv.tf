variable create_dotenv {
  default     = false
  type        = bool
  description = "true/false flag indicating whether to create a .env file environment variable exports"
}

resource "local_file" "dotenv" {
  count = var.create_dotenv ? 1 : 0
  content  = <<EOF
bigip1=${module.bigip.mgmt_public_ips[0]}
bigip2=${module.bigip.mgmt_public_ips[1]}
user=admin
password=${random_password.password.result}
EOF
  filename = "${path.module}/.env"
}