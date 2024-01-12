##########################
# Role ARN
##########################
variable "role_arn" {
  description = "IAM Role to assume in order to create Bitmovin User and Security Group"
  type        = string
  default     = null
}

##########################
# IAM User
##########################
variable "user_name" {
  description = "Bitmovin IAM user for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-cloud-connect-user"
}

variable "policy_name" {
  description = "Bitmovin Inline Policy for Cloud Connect Encoding"
  type        = string
  default     = "bitmovin-inline-policy"
}

##########################
# Security group
##########################
variable "security_group_name" {
  description = "Bitmovin Security Group for EC2 instances"
  type        = string
  default     = "bitmovin-security-group"
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

variable "live_ingress_cidr_blocks" {
  description = "All Ipv4"
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "live_ingress_ipv6_cidr_blocks" {
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
