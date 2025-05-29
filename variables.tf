# variables.tf
# Región de AWS donde desplegar la infraestructura (por defecto us-east-1)

variable "aws_region" {
description = "Región de AWS donde se desplegarán los recursos"
type = string
default = "us-east-1"
}

# Prefijo para nombres de recursos (por ejemplo, usar tus iniciales oproyecto)
variable "project_name" {
description = "Prefijo identificador para nombres de recursos en AWS"
type = string
default = "tfaws"
}

# VPC CIDR principal
variable "vpc_cidr" {
description = "Bloque CIDR para la VPC"
type = string
default = "10.0.0.0/16"
}

# Subredes públicas (lista de CIDR, una por zona de disponibilidad)
variable "public_subnets_cidrs" {
description = "Lista de bloques CIDR para subredes públicas"
type = list(string)
default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Subredes privadas (para base de datos/servidores privados)
variable "private_subnets_cidrs" {
description = "Lista de bloques CIDR para subredes privadas"
type = list(string)
default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# Nombre de par de claves SSH existente (opcional, si se desea acceso SSH a instancia)
variable "key_name" {
description = "Nombre de la key pair de EC2 para SSH"
type = string
default = "" # dejar vacío si no se usará SSH manual
}

# Tipo de instancia EC2 para los servidores web
variable "instance_type" {
description = "Tipo de instancia EC2 para los servidores web"
type = string
default = "t3.micro"
}

# Contraseñas para la BD y usuario de Wordpress
# Debe estar creado un secreto con nombre /wordpress/passwords
# En el secreto debe haber dos claves: db_password y demo_password
data "aws_secretsmanager_secret_version" "current" {
  secret_id = "/wordpress/passwords"
}

# Obtención y decodificación de las contraseñas del secreto
locals {
  db_password = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["db_password"]
  DEMO_PASSWORD = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)["demo_password"]
}

# Parámetros para la base de datos (RDS MySQL)
variable "db_name" {
description = "Nombre de la base de datos de WordPress en RDS"
type = string
default = "wordpress"
}
variable "db_username" {
description = "Usuario administrador de la base de datos RDS"
type = string
default = "admin"
}

variable "DOMAIN_NAME" {
  type        = string
  description = "Dominio para la instalación de WordPress"
  default     = "wordpress-iac-tf.midemo.com"
}

variable "DEMO_USERNAME" {
  type        = string
  description = "Usuario administrador para WordPress"
  default     = "wpadmin"
}

variable "DEMO_EMAIL" {
  type        = string
  description = "Email administrador para WordPress"
  default     = "admin@midemo.com"
}
