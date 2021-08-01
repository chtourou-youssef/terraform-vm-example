variable "region" {
  description = "name of region deployment"
  type = string
}
variable "subnet-name" {
  description = "name of subent network"
  type = string
}
variable "network-name" {
  description = "name of network name"
  type = string 
}
variable "zone" {
  description = "name of zone deployment"
  type = string
}
variable "user" {
  description = "vm username"
  type = string 
}
variable "sshpath" {
  description = "ssh public key path"
  type = string
}
variable "vmname" {
  description = "vm name"
  type = string
}
