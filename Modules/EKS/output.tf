output "endpoint" {
value = aws_eks_cluster.tessolve.endpoint
}
output "kubeconfig-certificate-authority-data" {
value = aws_eks_cluster.tessolve.certificate_authority[0].data
}
output "cluster_id" {
value = aws_eks_cluster.tessolve.id
}
output "cluster_endpoint" {
value = aws_eks_cluster.tessolve.endpoint
}
output "cluster_name" {
value = aws_eks_cluster.tessolve.name
}
