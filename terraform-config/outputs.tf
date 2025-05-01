output "eks_cluster_name" {
  description = "Nom du cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint du cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_oidc_provider_arn" {
  description = "ARN du fournisseur OIDC (pour IAM avec service accounts)"
  value       = module.eks.oidc_provider_arn
}

output "eks_worker_iam_role_name" {
  description = "Nom du rôle IAM utilisé par les nodes EKS"
  value       = module.eks.eks_managed_node_groups.default_node_group.iam_role_name
}
