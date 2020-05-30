variable "environment" {
  type        = string
  default     = "prod"
  description = "Environment the server belongs to"
}

variable "project_id" {
  type        = string
  description = "Packet Project ID"
}
