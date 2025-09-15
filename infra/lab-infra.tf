# Hybrid AD Lab Terraform Script
# This script provisions basic Azure resources for the hybrid lab described in lab_guide.md.
# It creates a resource group and a storage account for file shares or Azure File Sync, as referenced in the lab guide.

provider "azurerm" {
  features {}
}

# Resource Group for all lab resources
resource "azurerm_resource_group" "lab_rg" {
  name     = "hybrid-ad-lab-rg"
  location = "East US"
}

# Storage Account for lab file shares and Azure File Sync
# This matches the "File Shares + NTFS Permissions" and "Azure File Sync" steps in lab_guide.md
resource "azurerm_storage_account" "lab_storage" {
  name                     = "hybridadlabstorage"
  resource_group_name      = azurerm_resource_group.lab_rg.name
  location                 = azurerm_resource_group.lab_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
