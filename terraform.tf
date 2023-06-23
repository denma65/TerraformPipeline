terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }

  # https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
  backend "azurerm" {
    resource_group_name  = "TerraformState"
    storage_account_name = "terraformstate292"
    container_name       = "tfstate"
    key                  = "terraform.state"
  }

  #terraform {
  #  backend "azurerm" {
  #    storage_account_name  = "your_storage_account_name"
  #    container_name       = "your_container_name"
  #    key                  = "your_state_file_name"
  #    resource_group_name  = "your_resource_group_name"
  #    subscription_id      = "your_subscription_id"
  #    client_id            = "your_client_id"
  #    client_secret        = "your_client_secret"
  #    tenant_id            = "your_tenant_id"
  #  }
  #}

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
