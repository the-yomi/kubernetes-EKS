output "cluster_name" {
  value = aws_eks_cluster.kuber.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.kuber.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.kuber.certificate_authority[0].data
}