# Terraform Hands-on

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
* Step-by-step bullets
```
terraform apply
```
* 3.iamRole
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

## Help

Any advise for common problems or issues.
```
terraform --help
```

## Authors

Contributors names and contact info

[@KAPIL0123](https://twitter.com/KAPIL0123)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE License

## Acknowledgments

Inspiration, code snippets, etc.
* [Good Start](https://medium.com/avmconsulting-blog/provisioning-aws-infrastructure-with-terraform-6ab885fb3fcb)
* [Do More](https://devopsrealtime.com/deploy-apache-web-server-using-terraform-iac/)
* [S3 Object lock](https://medium.com/petabytz/protecting-data-with-amazon-s3-object-lock-7b47931fea73)
* [IAM Role with Terraform](https://devopslearning.medium.com/aws-iam-ec2-instance-role-using-terraform-fa2b21488536)

