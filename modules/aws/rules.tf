locals {
  ingress = "ingress"
  egress = "egress"

  all_ports = 0
  ssh_port = 22
  rtmp_port = 1935
  rtmps_port = 443
  zixi_port = 4444
  encoding_port = 9999
  encoding_port_https = 9443

  all_protocols = "-1"
  tcp = "tcp"
  udp = "udp"

  all_ipv4_network_blocks = ["0.0.0.0/0"]
  all_ipv6_network_blocks = ["::/0"]
  bitmovin_static_network_blocks = ["104.199.97.13/32", "35.205.157.162/32"]
  
  srt_ingress_rules = [
    { protocol = local.tcp, port = 2088 },
    { protocol = local.udp, port = 2088 },
    { protocol = local.tcp, port = 2089 },
    { protocol = local.tcp, port = 2090 },
    { protocol = local.tcp, port = 2091 },
    ]
    
  live_ipv4_network_blocks = can(var.live_ingress_ipv4_network_blocks) || !can(var.live_ingress_ipv6_network_blocks) ? var.live_ingress_ipv4_network_blocks : null
  live_ipv6_network_blocks = can(var.live_ingress_ipv6_network_blocks) || !can(var.live_ingress_ipv4_network_blocks) ? var.live_ingress_ipv6_network_blocks : null
}

resource "aws_security_group_rule" "all_traffic_within_ingress_rule" {
  description = "Allow communication between the main VM instance and the worker VM instances"
  
  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.all_ports
  to_port     = local.all_ports
  protocol    = local.all_protocols
  self        = true
}

resource "aws_security_group_rule" "encoding_service_ingress_rule" {
  description = "Allow communication with the service that manages the encoding"

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.encoding_port
  to_port     = local.encoding_port
  protocol    = local.tcp
  cidr_blocks = local.bitmovin_static_network_blocks
}

resource "aws_security_group_rule" "encoding_service_https_ingress_rule" {
  description = "Allow HTTPS communication with the service that manages the encoding"

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.encoding_port_https
  to_port     = local.encoding_port_https
  protocol    = local.tcp
  cidr_blocks = local.bitmovin_static_network_blocks
}

resource "aws_security_group_rule" "incoming_commands_ingress_rule" {
  description = "Allow incoming docker commands (i.e. pulling and starting docker containers)"

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.tcp
  cidr_blocks = local.bitmovin_static_network_blocks
}

resource "aws_security_group_rule" "all_traffic_egress_rule" {
  description = "Allow all outbound IPv4 traffic (i.e. responding to the service that manages the encoding, encoding output, temporary states)"

  security_group_id = aws_security_group.security_group.id
  type              = local.egress

  from_port   = local.all_ports
  to_port     = local.all_ports
  protocol    = local.all_protocols
  cidr_blocks = local.all_ipv4_network_blocks
}

resource "aws_security_group_rule" "live_rtmp_ingress_rule" {
  description = "Allow RTMP live streams"

  count = var.live_rtmp ? 1 : 0

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.rtmp_port
  to_port     = local.rtmp_port
  protocol    = local.tcp
  cidr_blocks = local.live_ipv4_network_blocks
  ipv6_cidr_blocks = local.live_ipv6_network_blocks
}

resource "aws_security_group_rule" "live_rtmps_ingress_rule" {
  description = "Allow RTMPS live streams"

  count = var.live_rtmp ? 1 : 0

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.rtmps_port
  to_port     = local.rtmps_port
  protocol    = local.tcp
  cidr_blocks = local.live_ipv4_network_blocks
  ipv6_cidr_blocks = local.live_ipv6_network_blocks
}

resource "aws_security_group_rule" "live_srt_ingress_rule" {
  description = "Allow SRT live streams"

  count = var.live_srt ? length(local.srt_ingress_rules) : 0

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.srt_ingress_rules[count.index].port
  to_port     = local.srt_ingress_rules[count.index].port
  protocol    = local.srt_ingress_rules[count.index].protocol

  cidr_blocks = local.live_ipv4_network_blocks
  ipv6_cidr_blocks = local.live_ipv6_network_blocks
}

resource "aws_security_group_rule" "live_zixi_ingress_rule" {
  description = "Allow Zixi live streams"

  count = var.live_zixi ? 1 : 0

  security_group_id = aws_security_group.security_group.id
  type              = local.ingress

  from_port   = local.zixi_port
  to_port     = local.zixi_port
  protocol    = local.tcp
  cidr_blocks = local.live_ipv4_network_blocks
  ipv6_cidr_blocks = local.live_ipv6_network_blocks
}
