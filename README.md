# How to generate tfscript

- no need to have tfstate file
- create `import.tf` file with code
```
import {
  id = "<VPC-ID>"
  to = aws_vpc.test-vpc
}
```

> Ref: [Youtube](https://www.youtube.com/watch?v=Za2BLzl1U5I)
> Ref: [https://blog.stackademic.com/terraform-import-and-automatic-code-generation-8dc7f979d7ef](https://blog.stackademic.com/terraform-import-and-automatic-code-generation-8dc7f979d7ef)

### Configure Terraform to use your AWS Account

> Use Way3
> Ref: [https://banhawy.medium.com/3-ways-to-configure-terraform-to-use-your-aws-account-fb00a08ded5](https://banhawy.medium.com/3-ways-to-configure-terraform-to-use-your-aws-account-fb00a08ded5)