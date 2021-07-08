terraform {
  backend "azurerm" {
    storage_account_name = "cottfstate"
    container_name       = "tfstate"
    key                  = "ddterraform.tfstate"
    access_key           = "X"
  }
}