provider "packet" {
  auth_token = var.auth_token
}

data "packet_project" "mkdev" {
  name = var.project_name
}

module "production-cluster" {
  source = "./modules/k3s-cluster"
  environment = "prod"
  project_id = data.packet_project.mkdev.id
}

