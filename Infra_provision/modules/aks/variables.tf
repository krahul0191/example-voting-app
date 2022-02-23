variable "rg_name" {
  default = "aks_rg"
}

variable "location" {
  default = "West US 2"
}

variable "location1" {
  default = "Central US"
}

variable "aks_name" {
  default = "kubernetes_cluster"
}

variable "acr_name" {
  default = "axrdemo"
}

variable "agent_count" {
  default = 1
}

variable "dns_prefix" {
  default = "kubes"
}

variable "vmsize" {
  default = "Standard_D2_v2"
}

variable "log_analytics_workspace_name" {
  default = "voteLogAnalyticsWorkspace"
}


# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}
