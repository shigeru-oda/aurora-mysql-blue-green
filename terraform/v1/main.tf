terraform {
  required_version = "1.9.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.71.0"
    }
  }
  backend "s3" {
    bucket  = "dev-terraform-aurora-mysql-blue-green"
    region  = "ap-northeast-1"
    key     = "dev-terraform-aurora-mysql-blue-green.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "ap-northeast-1" # 使用するリージョンに変更

  # 全リソースに共通のタグを適用
  default_tags {
    tags = {
      Name = "aurora-mysql-blue-green"
    }
  }
}

# 使用するCIDRブロックをlocalsに定義
locals {
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# AZ情報の取得
data "aws_availability_zones" "available" {}