# vpc
import {
  id = "vpc-0e0a9755e6083ab90"
  to = aws_vpc.nick_vpc
}

# aws_internet_gateway
import {
  id = "igw-0eccb215e788a7438"
  to = aws_internet_gateway.nick_ig
}

# aws_internet_gateway
import {
  id = "eipalloc-0eb7207121105bc18"
  to = aws_eip.nat_eip
}

# aws_nat_gateway
import {
  id = "nat-0c75cd12c40e04847"
  to = aws_nat_gateway.nat
}

# aws_subnet nick_subnet_public
import {
  id = "subnet-07fed7239a47a84a5"
  to = aws_subnet.nick_subnet_public
}

# aws_subnet nick_subnet_public_1
import {
  id = "subnet-0d7a3436865f59816"
  to = aws_subnet.nick_subnet_public_1
}

# aws_subnet nick_subnet_private
import {
  id = "subnet-0a375111bc7fad165"
  to = aws_subnet.nick_subnet_private
}

# aws_route_table nick_private_route_table
import {
  id = "rtb-0620126e7fce69c4e"
  to = aws_route_table.nick_private_route_table
}

# aws_route_table nick_public_route_table
import {
  id = "rtb-077c46327e5b6c3b5"
  to = aws_route_table.nick_public_route_table
}

# aws_route public_internet_gateway
import {
  id = "r-rtb-077c46327e5b6c3b51080289494"
  to = aws_route.public_internet_gateway
}

# aws_route private_nat_gateway
import {
  id = "r-rtb-0620126e7fce69c4e1080289494"
  to = aws_route.private_nat_gateway
}

# aws_security_group nick_default
import {
  id = "sg-0e8cb0557e1a7251d"
  to = aws_security_group.nick_default
}

#### ECS
# aws_security_group alb
import {
  id = "sg-0c06c699ed7443b98"
  to = aws_security_group.alb
}

# aws_security_group tg
import {
  id = "sg-0b1ee51c76879f41d"
  to = aws_security_group.tg
}

# aws_iam_role nick_ecs_task_role
import {
  id = "nick-ecsTaskRole"
  to = aws_iam_role.nick_ecs_task_role
}

# aws_iam_policy nick_ecs_task_role_policy
import {
  id = "nick-ecsTaskRole-20231226153935179100000002"
  to = aws_iam_policy.nick_ecs_task_role_policy
}

# aws_iam_role_policy_attachment nick_ecs_task_role_policy_attachment
import {
  id = "nick-ecsTaskRole-20231226153935179100000002"
  to = aws_iam_role_policy_attachment.nick_ecs_task_role_policy_attachment
}

# aws_iam_role nick_ecs_task_execution_role
import {
  id = "nick-ecsTaskExecutionRole"
  to = aws_iam_role.nick_ecs_task_execution_role
}

# aws_iam_role_policy_attachment nick_ecs_task_execution_role_policy_attachment
import {
  id = "nick-ecsTaskExecutionRole-20231226153935163100000001"
  to = aws_iam_role_policy_attachment.nick_ecs_task_execution_role_policy_attachment
}

# aws_ecs_cluster nick_ecs_cluster
import {
  id = "cluster/nick-ecs-cluster"
  to = aws_ecs_cluster.nick_ecs_cluster
}

# aws_ecs_task_definition nick_httpd_task
import {
  id = "nick-httpd-task"
  to = aws_ecs_task_definition.nick_httpd_task
}

# aws_lb nick_ecs_alb
import {
  id = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:loadbalancer/app/ecs-alb/8abe80cd76bd670c"
  to = aws_lb.nick_ecs_alb
}

# aws_alb_target_group nick_target_group
import {
  id = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:targetgroup/nick-tg/19167dec33c6100b"
  to = aws_alb_target_group.nick_target_group
}

# aws_alb_listener http
import {
  id = "arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:listener/app/ecs-alb/8abe80cd76bd670c/f2f539bcdc94648f"
  to = aws_alb_listener.http
}

# aws_service_discovery_private_dns_namespace service_discovery_dns
import {
  id = "ns-ktnbu325dihy6cfq"
  to = aws_service_discovery_private_dns_namespace.service_discovery_dns
}

# aws_service_discovery_service frontend
import {
  id = "srv-3slod7g7ii7tmb3l"
  to = aws_service_discovery_service.frontend
}

# aws_ecs_service nick_service
import {
  id = "arn:aws:ecs:ap-southeast-1:402100056167:service/nick-ecs-cluster/nick-service"
  to = aws_ecs_service.nick_service
}