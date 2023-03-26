resource "yandex_vpc_security_group" "default-sg" {
  name        = "default-sg"
  description = "Default SG for all compute"
  network_id  = yandex_vpc_network.default-net.id
  folder_id   = local.my_folder_id

  ingress {
    protocol       = "TCP"
    description    = "SSH from Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "mti-lab-seven-sg" {
  name        = "mti-lab-seven-sg"
  description = "Default SG for mti-lab-seven compute"
  network_id  = yandex_vpc_network.default-net.id
  folder_id   = local.my_folder_id

  ingress {
    protocol       = "TCP"
    description    = "HTTP from Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS from Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "TCP WG from Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 51820
  }

  ingress {
    protocol       = "UDP"
    description    = "UDP WG from Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 51820
  }

  egress {
    protocol       = "TCP"
    description    = "HTTPS to Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "UDP"
    description    = "DNS to Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 53
  }

  egress {
    protocol       = "TCP"
    description    = "DNS to Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 53
  }

  egress {
    protocol       = "TCP"
    description    = "HTTP to Internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
}
