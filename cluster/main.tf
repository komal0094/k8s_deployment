 resource "aws_eks_cluster" "eks_cluster" {
 name = "gg_eks_cluster"
 role_arn = var.role

 vpc_config {
  subnet_ids = [for v in var.snet: v.snet-id]
  security_group_ids = [var.sg-self]
 }
 }
 
 
 
 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  node_group_name = "gg_workernodes"
  node_role_arn  = var.node-role
  subnet_ids   = [for v in var.snet: v.snet-id]
 instance_types = ["t3a.medium"]
 
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 }