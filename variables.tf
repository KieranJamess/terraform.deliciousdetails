variable "name_prefix" {
  description = "Prefix of resources"
  default = "ddweb"
}

variable "location" {
  description = "Location of resources"
  default = "westeurope"
}

variable "docker_image" {
  description = "Linux docker image to use"
  default = "DOCKER|onlynothing/deliciousdetails:1.0.0"
}