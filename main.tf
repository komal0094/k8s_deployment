provider "aws" {
  region     = "ap-south-1"
  
}


//vpc module
module "nw" {
  source = "./nw"
  pub-snets = {
    pub-sub-1 = {
          availability_zone = "ap-south-1a"
        cidr_block = "10.0.0.0/18"
      },
      pub-sub-2 = {
          availability_zone = "ap-south-1b"
         cidr_block= "10.0.64.0/18"
      }
  }
  //private sub
  pri-snets = {
    pri-sub-1 = {
          availability_zone = "ap-south-1a"
        cidr_block = "10.0.128.0/18"
      },
      pri-sub-2 = {
          availability_zone = "ap-south-1b"
         cidr_block= "10.0.192.0/18"
      }
  }
  //nat gateway variable both
  # snt-id = "pub-sub-1"
  # nat-req = true
}

//sg module
module "sg" {
   source     = "./sg"
   sg_details = {
    "eks-sg" = {
        name = "test"
        description = "test"
        vpc_id = module.nw.vpc_id

        ingress_rules = [
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                # cidr_blocks = ["10.0.0.0/16"]
                security_groups = null
                self = true
            },
            {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                # cidr_blocks = ["10.0.0.0/16"]
                security_groups = null
                self = true
            }
            # {

            #     from_port = 443
            #     to_port   = 443
            #     protocol = "tcp"
            #     cidr_blocks = ["10.0.0.0/16"]
            #     security_groups = null
            #     self = true
            # }
        ]

  egress = {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    }}

   }


module "iam" {

  source = "./iam role"
}


module "cluster" {
    source = "./cluster"
    role = module.iam.role-arn
    node-role = module.iam.workernode-role-arn
    sg-self = lookup(module.sg.output-sg, "eks-sg", null)
    snet ={
        snet1 = {
        snet-id = lookup(module.nw.pub-snet-id, "pub-sub-1", null)
        },
        snet2 ={
        snet-id = lookup(module.nw.pub-snet-id, "pub-sub-2", null)
        }
    }
  
}