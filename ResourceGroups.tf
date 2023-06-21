variable "ResourceGroupList" {
  type = map(object({
    name = string
    tags = map(string)
  }))

  default = {
    Apps = {
      name = "Apps"
      tags = {
        Resource = "Apps"
      }
    },
    Backups = {
      name = "Backups"
      tags = {
        Resource = "Backups"
      }
    },
    DenOps = {
      name = "DenOps" #var.resourcegroup_Name
      tags = {}
    },
    Network = {
      name = "Network"
      tags = {
        Resource = "Network"
      }
    },
    StorageAccounts = {
      name = "StorageAccounts"
      tags = {
        Resource = "Storage"
      }
    }
  }
}

resource "azurerm_resource_group" "resource_groups" {
  for_each = var.ResourceGroupList

  name     = each.value.name
  location = var.default_Region
  tags     = merge(local.global_tags, each.value.tags)
}
