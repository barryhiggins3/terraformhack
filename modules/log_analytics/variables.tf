variable "name" {
  description = "Resource Group Name"
  Name = "loganalytics"
}
variable "resname" {
  description = "Resource Group Name"
}
variable "location" {
  default = "UK South"
  description = "location details"
  
}
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = "map"

  default = {
    application = "vdc-hub"
    environment = "development"
    buildagent  = "github-actions"
  }
}
variable "solutions" {
  description = "(Optional) Map structure containing the list of solutions to be enabled."
  type = "map"
  solution_plan_map = {
    ADAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADAssessment"
    },
    ADReplication = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADReplication"
    },
    AgentHealthAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/AgentHealthAssessment"
    },
    DnsAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/DnsAnalytics"
    },
    KeyVaultAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/KeyVaultAnalytics"
    }
}
}