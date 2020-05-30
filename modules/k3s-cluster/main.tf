data "terraform_remote_state" "globals" {
  backend = "s3"

  config = {
    bucket = "mkdev-terraform"
    region = "eu-central-1"
    key    = "globals.tfstate"
  }
}

resource "packet_project_ssh_key" "mkdev" {
  name       = "mkdev"
  public_key = file("/home/fodoj/.ssh/id_rsa.pub")
  project_id = var.project_id
}

resource "packet_device" "test" {
  hostname            = "mkdev-${var.environment}.test"
  plan                = "t1.small.x86"
  facilities          = ["ams1"]
  operating_system    = "centos_7"
  billing_cycle       = "hourly"
  project_ssh_key_ids = [packet_project_ssh_key.mkdev.id]
  project_id          = var.project_id
}

resource "aws_route53_record" "dns" {
  zone_id = data.terraform_remote_state.globals.outputs.zone_id
  name    = "mkdev-${var.environment}.labs.mkdev.me"
  type    = "A"
  ttl     = "300"

  records = [packet_device.test.access_public_ipv4]
}

output "public_ip" {
  value = packet_device.test.access_public_ipv4
}

