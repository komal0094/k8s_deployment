output "output-sg" {
    value = {for k, v in aws_security_group.sg_001: k => v.id}
  
}