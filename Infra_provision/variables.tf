variable "subscription_id" {
    description = "The subscription ID to be used to connect to Azure"
    type = string
    default = "provide subscription ID"
}
variable "client_id" {
    description = "The client ID to be used to connect to Azure"
    type = string
    default = "provide Client/Application ID"
}
variable "client_secret" {
    description = "The client secret to be used to connect to Azure"
    type = string
    default = "Provide client secret value"
}
variable "tenant_id" {
    description = "The tenant ID to be used to connect to Azure"
    type = string
    default = "provide tenant value"
}