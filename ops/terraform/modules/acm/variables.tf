variable "domain_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "certificate_alternative_names" {
  type = list(string)
}
