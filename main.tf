locals {
dnsRecords = jsondecode(file("${path.module}/dns-records.json"))
// dnsRecords = {
//     key = { name="abc.julia.vorozhko.net", records="1.1.1.1" }
//     key2 = { name="abcd.julia.vorozhko.net", records="2.2.2.2" }
// }


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
