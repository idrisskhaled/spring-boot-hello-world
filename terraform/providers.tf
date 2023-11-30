terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id = "d196182c-349c-4155-9e9b-8cf25a9408c1"
  client_secret = "5aQ8Q~vARR18Rqyd6MtQCF~wX3yAbQMbvfqP1bSz"
  tenant_id = "dbd6664d-4eb9-46eb-99d8-5c43ba153c61"
  subscription_id = "e17aee72-105c-4866-a453-005f07809bd2"
}
