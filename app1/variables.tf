variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
}

variable "vpc_network_name" {
  type        = string
  description = "The name of the VPC network."
}

variable "subnets" {
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
  description = "The list of subnets to be created."
  default     = []
}
