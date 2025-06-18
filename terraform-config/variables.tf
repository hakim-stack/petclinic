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

variable "eks_security_group_id" {
  description = "Optionnel : ID d’un groupe de sécurité EKS à utiliser si déjà existant (sinon créé par Terraform)"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Nom de domaine pour le certificat SSL (ex: monsite.com)"
  type        = string
}

variable "zone_id" {
  description = "ID de la zone hébergée Route 53 (ex: Z1234567ABCDEF)"
  type        = string
}

variable "region" {
  description = "Région AWS (ex: eu-west-3)"
  type        = string
  default     = "eu-west-3"
}



