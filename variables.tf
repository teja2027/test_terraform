# Project variables
variable "location" {
  type = string
  description = "The location for the deployment"
  default = "eastus"
}

variable "rsgname" {
  type = string
  description = "Resouce Group name"
  default = "myRg1"
}

variable "stgactname" {
  type = string
  description = "Storage Account name"
  default = "tfstate011962384904"
}

variable "prefix" {
  type = string
  description = "vm name prefix"
  default = "testvm"
}