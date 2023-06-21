/*
# Example from HashiCorp showing validation
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {
    project     = "my-project",
    environment = "dev"
  }

  validation {
    condition     = length(var.resource_tags["project"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["project"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.resource_tags["environment"]) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["environment"])) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}
*/

locals {
  global_tags = {
    #Environment = var.tag_entry_Environment
    Organisation = var.resourcegroup_Name
    #Team         = var.tag_entry_Team
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

#variable "tag_entry_Environment" {
#  type    = string
#  default = "Test"
#}

variable "tag_entry_Team" {
  type    = string
  default = ""
}

variable "vnet_AddressSpace" {
  type    = string
  default = "10.0.20.0/24"
}

#
# Check this out for switching between range and ranges
# https://stackoverflow.com/questions/66585413/terraform-azurerm-provider-count-and-csvdecode#:~:text=destination_port_ranges%20-%20%28Optional%29%20List%20of%20destination%20ports%20or,the%20csv%20file%20for%20the%20network%20security%20rules.
#

locals {
  default_nsgrules = {
    AllowInternalRDP = {
      access                     = "Allow"
      description                = "Allow internal RDP traffic inbound"
      destination_address_prefix = "VirtualNetwork"
      destination_port_range     = "3389"
      direction                  = "Inbound"
      name                       = "AllowRdpInbound"
      priority                   = 4093
      protocol                   = "Tcp"
      source_address_prefix      = "VirtualNetwork"
      source_port_range          = "*"
    }
    AllowAzureLoadBalancerInBound = {
      access                     = "Allow"
      description                = "Allow inbound Azure Load Balancer health check."
      destination_address_prefix = "*"
      destination_port_range     = 443
      direction                  = "Inbound"
      name                       = "AllowAzureLoadBalancerInBound"
      priority                   = 4094
      protocol                   = "Tcp"
      source_address_prefix      = "AzureLoadBalancer"
      source_port_range          = "*"
    }
    AllowICMPInbound = {
      access                     = "Allow"
      description                = "Allow ping requests inbound"
      destination_address_prefix = "VirtualNetwork"
      destination_port_range     = "*"
      direction                  = "Inbound"
      name                       = "AllowICMPInbound"
      priority                   = 4095
      protocol                   = "Icmp"
      source_address_prefix      = "VirtualNetwork"
      source_port_range          = "*"
    }
    AllowICMPOutbound = {
      access                     = "Allow"
      description                = "Allow ping requests outbound"
      destination_address_prefix = "VirtualNetwork"
      destination_port_range     = "*"
      direction                  = "Outbound"
      name                       = "AllowICMPOutbound"
      priority                   = 4095
      protocol                   = "Icmp"
      source_address_prefix      = "VirtualNetwork"
      source_port_range          = "*"
    }
    DenyAllInBound = {
      access                     = "Deny"
      description                = ""
      destination_address_prefix = "*"
      destination_port_range     = "*"
      direction                  = "Inbound"
      name                       = "DenyAllInbound"
      priority                   = 4096
      protocol                   = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    DenyAllOutbound = {
      access                     = "Deny"
      description                = ""
      destination_address_prefix = "*"
      destination_port_range     = "*"
      direction                  = "Outbound"
      name                       = "DenyAllOutbound"
      priority                   = 4096
      protocol                   = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
  }
}
