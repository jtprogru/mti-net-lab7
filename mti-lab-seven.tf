resource "yandex_vpc_address" "mti-lab-seven-addr" {
  name        = "mti-lab-seven-addr"
  description = "mti-lab-seven external public IPv4"
  folder_id   = local.my_folder_id

  external_ipv4_address {
    zone_id = local.region_ru_central1_a
  }
}

resource "cloudflare_record" "mti-lab-seven-a" {
  zone_id = local.cf_zone_id_my_domain
  name    = "mtil7"
  value   = yandex_vpc_address.mti-lab-seven-addr.external_ipv4_address.0.address
  type    = "A"
  ttl     = 60
}

resource "yandex_compute_instance" "mti-lab-seven" {
  name               = "mti-lab-seven"
  hostname           = "mti-lab-seven"
  platform_id        = local.compute_platform_sv3
  zone               = local.region_ru_central1_a
  description        = "mti-lab-seven compute managed by Terraform"
  service_account_id = local.default_sa_id

  labels = {
    type   = "mti-lab-seven",
    subnet = yandex_vpc_subnet.default-subnet-a.name,
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id = local.image_id_ubuntu2204
      size     = 10
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.default-subnet-a.id
    nat            = true
    nat_ip_address = yandex_vpc_address.mti-lab-seven-addr.external_ipv4_address.0.address
    security_group_ids = [
      yandex_vpc_security_group.mti-lab-seven-sg.id,
      yandex_vpc_security_group.default-sg.id,
    ]
  }

  metadata = {
    user-data = file("cloud-init/ci.yaml")
  }
}

