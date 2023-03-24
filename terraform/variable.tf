variable "aws_region" {}
variable "domain_name" {}
variable "r_prefix" {
  default = "formatter"
}
locals {
  fqdn = {
    web_name = "web.${var.domain_name}"
  }
  bucket = {
    name = local.fqdn.web_name
  }
}