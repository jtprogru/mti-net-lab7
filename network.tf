resource "yandex_vpc_network" "default-net" {
  name        = "default-net"
  description = "Default network managed by Terraform"
}

resource "yandex_vpc_subnet" "default-subnet-a" {
  name           = "default-subnet-a"
  zone           = local.region_ru_central1_a
  description    = "Default subnet managed by Terraform"
  v4_cidr_blocks = ["10.20.217.0/24"]
  network_id     = yandex_vpc_network.default-net.id
}
