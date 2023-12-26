#!/bin/sh

terraform import aws_alb_listener.http arn:aws:elasticloadbalancing:ap-southeast-1:402100056167:listener/app/ecs-alb/8abe80cd76bd670c/f2f539bcdc94648f \
&& terraform import aws_service_discovery_private_dns_namespace.service_discovery_dns ns-ktnbu325dihy6cfq:vpc-0e0a9755e6083ab90 \
&& terraform import aws_service_discovery_service.frontend srv-3slod7g7ii7tmb3l \
&& terraform import aws_ecs_service.nick_service nick-ecs-cluster/nick-service