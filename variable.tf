variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "private_cidrs" {
  default = "10.0.2.0/24"
}

variable "public_key_path" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}
variable "install_script" {
  description = "s/w install script"
  default     = "install.sh"

}
