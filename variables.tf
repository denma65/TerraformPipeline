locals {
  global_tags = {
    Organisation = var.resourcegroup_Name
  }
}

variable "default_Region" {
  type    = string
  default = ""
}

variable "default_VM_AdminUserName" {
  description = "Local admin username for new vms"
  type        = string
  sensitive   = true
  default     = ""
}

variable "default_VM_AdminPassword" {
  description = "Local admin password for new vms"
  type        = string
  sensitive   = true
  default     = ""
}

variable "resourcegroup_Name" {
  type    = string
  default = ""
}

variable "resource_group_Name" {
  type    = string
  default = ""
}

variable "tag_entry_Team" {
  type    = string
  default = ""
}
