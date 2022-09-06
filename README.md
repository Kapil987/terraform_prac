# Terraform Hands-On
![alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Terraform_Logo.svg/2560px-Terraform_Logo.svg.png)

## Description

The intenstion of this repository is to learn IaaC approach with AWS

## Getting Started

Build, change, and destroy infrastructure with Terraform. Start here to learn the basics of Terraform with your favorite cloud provider.

### Dependencies

* An IDE (VScode preferred)
* Windows 7 or higher

### Installing

* Follow instruction from https://learn.hashicorp.com/tutorials/terraform/install-cli

### Executing program

* How to run the program
```
terraform apply
```
* c3.iamRole
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789012:user/my-test-user-name"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}

```
* k10.openVPN_aws
> Subscribing to Open VPN as we need to accept the terms
![subscribe Open VPN](https://github.com/Kapil987/terraform_prac/blob/main/k10.openVPN_aws/images/openVPN_sub1.PNG)

> Connecting with private IP
![private_ip_access](https://github.com/Kapil987/terraform_prac/blob/main/k10.openVPN_aws/images/access_private_ip.PNG)

## Help

Any advise for common problems or issues.
```
terraform --help
```

## Authors

[@KAPIL0123](https://twitter.com/KAPIL0123)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE License

## Acknowledgments

Inspiration, code snippets, etc.
* [Provisioning-aws-infrastructure-with-terraform](https://medium.com/avmconsulting-blog/provisioning-aws-infrastructure-with-terraform-6ab885fb3fcb)
* [Assignement](https://devopsrealtime.com/deploy-apache-web-server-using-terraform-iac/)
* [S3 Object lock](https://medium.com/petabytz/protecting-data-with-amazon-s3-object-lock-7b47931fea73)
* [IAM Role with Terraform](https://devopslearning.medium.com/aws-iam-ec2-instance-role-using-terraform-fa2b21488536)
* [tfstate file recovery](https://medium.com/@abtreece/recovering-terraform-state-69c9966db71e)
* [S3 backends data source](https://www.terraform.io/language/settings/backends/s3)
* [Remote State data Sources Usage](https://stackoverflow.com/questions/57131972/how-to-use-remote-state-data-sources-within-child-modules)