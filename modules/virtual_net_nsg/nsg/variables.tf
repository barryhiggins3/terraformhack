variable "location" {
  default     = "UK South"
  description = "location details"
}
variable "resname" {
  description = "Resource Group Name"
}
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map

  default = {
    application = "vdc-hub"
    environment = "development"
    buildagent  = "github-actions"
  }
}
<<<<<<< HEAD
=======
variable "rules" {
  description = "The rule set for the network security group."
}
variable "nsgname" {
  description = "Network security group name."
}
>>>>>>> 86515397c3ae9e8d5d7e01cd690ef4604f44d846
