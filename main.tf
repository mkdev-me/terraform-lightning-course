provider "packet" {
  auth_token = var.auth_token
}

data "packet_project" "mkdev" {
  name = var.project_name
}

resource "packet_project_ssh_key" "mkdev" {
  name       = "mkdev"
  public_key = file("/home/fodoj/.ssh/id_rsa.pub")
  project_id = data.packet_project.mkdev.id
}

resource "packet_device" "test" {
  hostname            = "mkdev-${var.environment}.test"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "centos_7"
  billing_cycle       = "hourly"
  project_ssh_key_ids = [packet_project_ssh_key.mkdev.id]
  project_id          = data.packet_project.mkdev.id
}

output "public_ip" {
  value = packet_device.test.access_public_ipv4
}

