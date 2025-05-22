variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "project_name" {
  description = "Nom du projet pour le préfixe des ressources"
  type        = string
  default     = "petclinic"
}

variable "vpc_cidr" {
  description = "CIDR du VPC principal"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  description = "CIDR pour le subnet 1"
  type        = string
  default     = "10.0.0.0/20"
}

variable "subnet2_cidr" {
  description = "CIDR pour le subnet 2"
  type        = string
  default     = "10.0.16.0/20"
}

variable "availability_zone_1" {
  description = "AZ pour le subnet 1"
  type        = string
  default     = "eu-west-3a"
}

variable "availability_zone_2" {
  description = "AZ pour le subnet 2"
  type        = string
  default     = "eu-west-3b"
}

variable "node_group_name" {
  description = "Nom du groupe de nœuds EKS"
  type        = string
  default     = "default-node-group"
}

variable "node_group_instance_types" {
  description = "Types d'instances EC2 pour les nœuds EKS"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_desired_size" {
  description = "Taille désirée du groupe de nœuds"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Taille minimale du groupe de nœuds"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Taille maximale du groupe de nœuds"
  type        = number
  default     = 3
}
