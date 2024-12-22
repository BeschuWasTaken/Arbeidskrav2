variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "install_script_url" {
  description = "URL to the MariaDB installation script"
  type        = string
  default     = "mariadbinstall"
}