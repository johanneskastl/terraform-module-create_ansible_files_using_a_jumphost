#
# Ansible inventory
#

variable "inventory_file_name_with_path" {
  description = "File name for the new file"
  default     = "ansible/terraform_ansible_inventory"
}

variable "inventory_file_permissions" {
  description = "Permissions for the new file"
  default     = "0644"
}

variable "groups_with_floating_ips" {
  description = "Instance objects created using the create_instance_with_floating_ip module"
  type        = list
}

variable "groups_without_floating_ips" {
  description = "Instance objects created using the terraform-module-create_instance_without_floating_ip module"
  type        = list
}
