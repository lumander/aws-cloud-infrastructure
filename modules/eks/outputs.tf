output "endpoint" {
  value = aws_eks_cluster.eks_services.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_services.certificate_authority[0].data
}