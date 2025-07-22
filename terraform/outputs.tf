output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "region" {
  value = var.region
}

# output "eks_admin_access_key_id" {
#   value     = aws_iam_access_key.eks_admin.id
#   sensitive = true
# }

# output "eks_admin_secret_access_key" {
#   value     = aws_iam_access_key.eks_admin.secret
#   sensitive = true
# }