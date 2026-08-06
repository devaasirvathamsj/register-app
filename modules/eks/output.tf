output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "node_security_group_id" {
  value = aws_security_group.eks_node_sg.id
}

output "node_group_name" {
  value = aws_eks_node_group.main.node_group_name
}