terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "TerraformState"
    storage_account_name = "terraformstate292"
    container_name       = "tfstate"
    key                  = "terraform.state"
  }

  #cloud {
  #  organization = "WRTech"
  #  workspaces {
  #    name = "DenOps"
  #  }
  #}
}

provider "azurerm" {
  features {
    resource_group {
      ## CAREFUL WITH THIS ONE AS IT REMOVES NEW/ADDITIONAL RESOURCES
      ## COMMENT THE LINE OUT BELOW AFTER TESTING
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}
