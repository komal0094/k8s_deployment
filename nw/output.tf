output "vpc_id" {
    value = aws_vpc.my-vpc001.id
  
}
# output "pub-snet-id" {
#     value = aws_subnet.pub-subnet
# }
output "pub-snet-id" {
    value = {for k, v in aws_subnet.pub-subnet: k => v.id}
  
}