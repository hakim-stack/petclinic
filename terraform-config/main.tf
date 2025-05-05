resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet-2"
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name}-route-table"
  }
}

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

# 👇 Récupération d'une clé KMS existante (à la place de la créer)
data "aws_kms_alias" "eks" {
  name = "alias/eks/petclinic-eks"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id                   = aws_vpc.main.id
  subnet_ids               = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  control_plane_subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  # ✅ Création d’une nouvelle clé KMS avec alias propre
  create_kms_key  = true
  kms_key_aliases = ["eks/${var.project_name}-eks-v2"]

  # ✅ Configuration du chiffrement
  cluster_encryption_config = {
    resources = ["secrets"]
  }

  # ✅ Empêcher la création du log group (pour éviter conflits)
  cluster_enabled_log_types = []

  eks_managed_node_groups = {
    default_node_group = {
      desired_size    = 2
      max_size        = 3
      min_size        = 1
      instance_types  = ["t3.medium"]
    }
  }

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}
