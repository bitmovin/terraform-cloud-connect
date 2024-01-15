##########################
# IAM User
##########################
variable "user_name" {
  description = "Name of the Bitmovin IAM user for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect"
}

variable "policy_name" {
  description = "Name of the Bitmovin Inline Policy for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect"
}

##########################
# Security group
##########################
variable "security_group_name" {
  description = "Name of the Bitmovin Security Group for Cloud Connect Encoding"
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
  description = "All Ipv4"
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "live_ingress_ipv6_network_blocks" {
  description = "All Ipv6"
  type    = list(string)
  default = ["::/0"]
}

##########################
# Tags
##########################
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {
                  company = "bitmovin",
                  product = "cloud-connect"
                }
}
