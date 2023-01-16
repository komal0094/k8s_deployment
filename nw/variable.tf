variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}


variable "all_traffic_allow" {
    type = string
    default = "0.0.0.0/0"
  
 }

///for each variable
variable "pub-snets" {
    type = map(object({
  cidr_block = string
  availability_zone = string
    }))
}
//private subnet
variable "pri-snets" {
    type = map(object({
  cidr_block = string
  availability_zone = string
    }))
}