variable "location" {
  description = "The location/region in which to create the resources."
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "myResourceGroup"
}
