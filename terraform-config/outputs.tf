output "eks_cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint du cluster EKS"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_oidc_provider_arn" {
  description = "ARN du fournisseur OIDC (pour IAM avec service accounts)"
  value       = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "eks_worker_iam_role_name" {
  description = "Nom du rôle IAM utilisé par les nodes EKS"
  value       = aws_iam_role.eks_node_role.name
}
