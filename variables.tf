variable "service_account_auth_key" {
  default     = ""
  description = "SA key in JSON for access to Yandex.Cloud"
  sensitive   = true
}

variable "default_mdb_mysql_password" {
  default     = ""
  description = "Default password for all MDB MySQL clusters"
  sensitive   = true
}

variable "cloudflare_api_token" {
  default     = ""
  description = "CF Api key"
  sensitive   = true
}
