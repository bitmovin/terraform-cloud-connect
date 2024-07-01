##########################
# Project
##########################
variable "project_id" {
  description = "Project ID of the Bitmovin project for Cloud Connect Encoding"
  type        = string
}

##########################
# Service account
##########################
variable "account_id" {
  description = "Account ID of the Service Account user for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect-user"
}

variable "user_name" {
  description = "Name of the Service Account user for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect-user"
}

##########################
# VPC network
##########################
variable "network_name" {
  description = "Auto-mode VPC network for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect"
}

variable "live_rtmp" {
  description = "Whether to support RTMP live streams"
  type        = bool
  default     = false
}

variable "live_srt" {
  description = "Whether to support SRT live streams"
  type        = bool
  default     = false
}

variable "live_zixi" {
  description = "Whether to support Zixi live streams"
  type        = bool
  default     = false
}

variable "live_ingress_ipv4_network_blocks" {
  description = "All IPv4"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
