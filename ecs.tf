# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "ns-ktnbu325dihy6cfq:vpc-0e0a9755e6083ab90"
resource "aws_service_discovery_private_dns_namespace" "service_discovery_dns" {
  description = "dns for ECS's service"
  name        = "nick.com"
  tags        = {}
  tags_all    = {}
  vpc         = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_service_discovery_service" "frontend" {
  name          = "frontend"
  namespace_id  = "ns-ktnbu325dihy6cfq"
  tags          = {}
  tags_all      = {}
  dns_config {
    namespace_id   = "ns-ktnbu325dihy6cfq"
    routing_policy = "MULTIVALUE"
    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 5
  }
}

# __generated__ by Terraform from "arn:aws:ecs:ap-southeast-1:402100056167:task-definition/nick-httpd-task:3"
resource "aws_ecs_task_definition" "nick_httpd_task" {
  container_definitions    = "[{\"cpu\":0,\"environment\":[],\"essential\":true,\"image\":\"httpd:2.4\",\"mountPoints\":[],\"name\":\"nick-container\",\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"}],\"volumesFrom\":[]}]"
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::402100056167:role/nick-ecsTaskExecutionRole"
  family                   = "nick-httpd-task"
  ipc_mode                 = null
  memory                   = "512"
  network_mode             = "awsvpc"
  pid_mode                 = null
  requires_compatibilities = ["FARGATE"]
  skip_destroy             = null
  tags                     = {}
  tags_all                 = {}
  task_role_arn            = "arn:aws:iam::402100056167:role/nick-ecsTaskRole"
}

# __generated__ by Terraform
resource "aws_lb" "nick_ecs_alb" {
  desync_mitigation_mode                                       = "defensive"
  drop_invalid_header_fields                                   = false
  enable_cross_zone_load_balancing                             = true
  enable_deletion_protection                                   = false
  enable_http2                                                 = true
  enable_tls_version_and_cipher_suite_headers                  = false
  enable_waf_fail_open                                         = false
  enable_xff_client_port                                       = false
  idle_timeout                                                 = 60
  internal                                                     = false
  ip_address_type                                              = "ipv4"
  load_balancer_type                                           = "application"
  name                                                         = "ecs-alb"
  preserve_host_header                                         = false
  security_groups                                              = ["sg-0c06c699ed7443b98"]
  subnets                                                      = ["subnet-07fed7239a47a84a5", "subnet-0d7a3436865f59816"]
  tags = {
    Name = "ecs-alb"
  }
  tags_all = {
    Name = "ecs-alb"
  }
  xff_header_processing_mode = "append"
  access_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  connection_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
}

# __generated__ by Terraform
resource "aws_alb_target_group" "nick_target_group" {
  connection_termination             = null
  deregistration_delay               = "300"
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = null
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  name                               = "nick-tg"
  name_prefix                        = null
  port                               = 80
  preserve_client_ip                 = null
  protocol                           = "HTTP"
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = null
  slow_start                         = 0
  tags                               = {}
  tags_all                           = {}
  target_type                        = "ip"
  vpc_id                             = "vpc-0e0a9755e6083ab90"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

# __generated__ by Terraform from "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:listener/app/ecs-alb/8abe80cd76bd670c/f2f539bcdc94648f"
resource "aws_alb_listener" "http" {
  alpn_policy       = null
  certificate_arn   = null
  load_balancer_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:loadbalancer/app/ecs-alb/8abe80cd76bd670c"
  port              = 80
  protocol          = "HTTP"
  ssl_policy        = null
  tags              = {}
  tags_all          = {}
  default_action {
    order            = 1
    target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:targetgroup/nick-tg/19167dec33c6100b"
    type             = "forward"
  }
}

# __generated__ by Terraform from "nick-ecs-cluster/nick-service"
resource "aws_ecs_service" "nick_service" {
  cluster                            = "arn:aws:ecs:ap-southeast-1:402100056167:cluster/nick-ecs-cluster"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  enable_ecs_managed_tags            = false
  enable_execute_command             = false
  force_new_deployment               = null
  health_check_grace_period_seconds  = 0
  iam_role                           = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type                        = "FARGATE"
  name                               = "nick-service"
  platform_version                   = "LATEST"
  propagate_tags                     = "NONE"
  scheduling_strategy                = "REPLICA"
  tags                               = {}
  tags_all                           = {}
  task_definition                    = "nick-httpd-task:3"
  triggers                           = {}
  wait_for_steady_state              = null
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }
  deployment_controller {
    type = "ECS"
  }
  load_balancer {
    container_name   = "nick-container"
    container_port   = 80
    elb_name         = null
    target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:targetgroup/nick-tg/19167dec33c6100b"
  }
  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-0b1ee51c76879f41d"]
    subnets          = ["subnet-07fed7239a47a84a5"]
  }
  service_registries {
    container_name = null
    container_port = 0
    port           = 0
    registry_arn   = "arn:aws:servicediscovery:ap-southeast-1:402100056167:service/srv-3slod7g7ii7tmb3l"
  }
}

# __generated__ by Terraform
resource "aws_nat_gateway" "nat" {
  allocation_id                      = "eipalloc-0eb7207121105bc18"
  connectivity_type                  = "public"
  private_ip                         = "10.0.1.50"
  subnet_id                          = "subnet-07fed7239a47a84a5"
  tags = {
    Name = "nat"
  }
  tags_all = {
    Name = "nat"
  }
}

# __generated__ by Terraform from "sg-0c06c699ed7443b98"
resource "aws_security_group" "alb" {
  description = "Managed by Terraform"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 443
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "nick-sg-alb"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_subnet" "nick_subnet_public_1" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-southeast-1b"
  cidr_block                                     = "10.0.4.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  tags = {
    Name = "nick_subnet_public_1"
  }
  tags_all = {
    Name = "nick_subnet_public_1"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_subnet" "nick_subnet_public" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-southeast-1a"
  cidr_block                                     = "10.0.1.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = true
  tags = {
    Name = "nick_subnet_public"
  }
  tags_all = {
    Name = "nick_subnet_public"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_route_table" "nick_private_route_table" {
  tags = {
    Name = "nick_private_route_table"
  }
  tags_all = {
    Name = "nick_private_route_table"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform from "sg-0e8cb0557e1a7251d"
resource "aws_security_group" "nick_default" {
  description = "Default SG to alllow traffic from the VPC"
  egress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = true
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = true
    to_port          = 0
  }]
  name                   = "nick-default-sg"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_subnet" "nick_subnet_private" {
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "ap-southeast-1a"
  cidr_block                                     = "10.0.2.0/24"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_public_ip_on_launch                        = false
  tags = {
    Name = "nick_subnet_private"
  }
  tags_all = {
    Name = "nick_subnet_private"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform from "sg-0b1ee51c76879f41d"
resource "aws_security_group" "tg" {
  description = "Managed by Terraform"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "nick-sg-tg"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform
resource "aws_route_table" "nick_public_route_table" {
  tags = {
    Name = "nick_public_route_table"
  }
  tags_all = {
    Name = "nick_public_route_table"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform from "igw-0eccb215e788a7438"
resource "aws_internet_gateway" "nick_ig" {
  tags = {
    Name = "nick_igw"
  }
  tags_all = {
    Name = "nick_igw"
  }
  vpc_id = "vpc-0e0a9755e6083ab90"
}

# __generated__ by Terraform from "eipalloc-0eb7207121105bc18"
resource "aws_eip" "nat_eip" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  domain                    = "vpc"
  instance                  = null
  network_border_group      = "ap-southeast-1"
  network_interface         = "eni-0a144535dde3563db"
  public_ipv4_pool          = "amazon"
  tags                      = {}
  tags_all                  = {}
}

# __generated__ by Terraform
resource "aws_vpc" "nick_vpc" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Name = "nick_vpc"
  }
  tags_all = {
    Name = "nick_vpc"
  }
}

# __generated__ by Terraform from "nick-ecsTaskRole"
resource "aws_iam_role" "nick_ecs_task_role" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ecs-tasks.amazonaws.com\"},\"Sid\":\"\"}],\"Version\":\"2012-10-17\"}"
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::402100056167:policy/nick-task-role-policy"]
  max_session_duration  = 3600
  name                  = "nick-ecsTaskRole"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}

# __generated__ by Terraform from "nick-ecsTaskExecutionRole"
resource "aws_iam_role" "nick_ecs_task_execution_role" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ecs-tasks.amazonaws.com\"},\"Sid\":\"\"}],\"Version\":\"2012-10-17\"}"
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  max_session_duration  = 3600
  name                  = "nick-ecsTaskExecutionRole"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
