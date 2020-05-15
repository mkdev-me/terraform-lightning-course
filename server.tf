provider "packet" {
  auth_token = "INSERT_YOUR_TOKEN"
}

resource "packet_project" "mkdev" {
  name = "mkdev"
}

resource "packet_project_ssh_key" "mkdev" {
  name = "mkdev"
  public_key = file("/path/to/your/publick/key.pub")
  project_id = packet_project.mkdev.id
}

resource "packet_device" "test" {
  hostname = "mkdev.test"
  plan = "t1.small.x86"
  facilities = ["ams1"]
  operating_system = "centos_7"
  billing_cycle = "hourly"
  project_ssh_key_ids = [packet_project_ssh_key.mkdev.id]
  project_id = packet_project.mkdev.id
}

output "public_ip" {
  value = packet_device.test.access_public_ipv4
}

