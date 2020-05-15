variable "auth_token" {
  type = string
  description = "Packet Cloud Auth Token"
}

variable "environment" {
  type = string
  default = "prod"
  description = "Environment the server belongs to"
}

variable "project_name" {
  type = string
  description = "Packet Project name for all resources"
}
