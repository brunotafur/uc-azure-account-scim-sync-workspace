
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.24.1"
    }
  }
}

provider "azuread" {
  # Configuration options
}

# TODO: configure companion mode for enterprise app (EA) sync
# WARNING: this variables MUST be set once and not changed
#   if ea_companion_mode changes from `false` (terraform maintains users) to `true` (terraform does not maintain users anymore)
#   when terraform has state file, it will be seen as request to delete users from account console
locals {
  ea_cfg = {
    # when set to true, EA will handle syncing users, terraform will not sync users
    # when set to false, terraform will sync users
    ea_companion_mode : false
  }
}

# TODO: update your databricks connection details here
#provider "databricks" {
#  host       = "https://accounts.azuredatabricks.net"
#  account_id = "c3d0c960-58a1-4b23-b7f5-de6ca6fc1e2b"
#}
provider "databricks" {
  host  = "https://adb-3923253141441028.8.azuredatabricks.net/"
}

# TODO: update this with storage where state will be kept
terraform {
  backend "azurerm" {
    subscription_id      = "4a7cb191-ac11-4a59-99b2-3cc37d85af8e"
    resource_group_name  = "databricks-btafur-rg-0211"
    storage_account_name = "testbtstorageaccount"
    container_name       = "tfstate"
    key                  = "scim-sync.tfstate"
    use_azuread_auth     = true
  }
}
  