## Manage DNS records on AWS using Terraform  

Terraform module which manage DNS records on AWS using a .json file.

## What will be created

DNS records will be created from the dns-records.json file in AWS Route53.
This file described all the DNS records that we wanted to add to Route53.

## Usage

Terraform code uses the aws_route53_record resource and the for_each statement. 

```hcl
locals {
dnsRecords = jsondecode(file("${path.module}/dns-records.json"))
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_route53_record" "www" {
    for_each = local.dnsRecords
  
    name    = each.value.name
    records = each.value.records

    zone_id = "Z0060735WXZJMKCFZ092"    
    type    = each.value.type
    ttl     = "300"
}

```

for_each statement works like Value - Variable.

for_each takes information about DNS records and type records from the dns-records.json file and adds to the Hosted zone in a loop.

## Inputs

- local .json file with DNS Records 
- Hosted zone id - zone_id