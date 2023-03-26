terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "terraform-bucket-name"
    region                      = "ru-central1-a"
    key                         = "terraform.tfstate"
    encrypt                     = true
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = jsonencode(var.service_account_auth_key)
  cloud_id                 = local.my_cloud_id
  folder_id                = local.my_folder_id
  zone                     = "ru-central1-a"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
