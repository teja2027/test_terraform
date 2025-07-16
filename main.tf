terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }
backend "azurerm" {
    resource_group_name = "myRg"
    storage_account_name = "tfstate011962384904"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}



