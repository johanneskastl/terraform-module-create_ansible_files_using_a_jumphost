![Terraform GitHub Actions](https://github.com/johanneskastl/terraform-module-create_ansible_files_using_a_jumphost/workflows/Terraform%20GitHub%20Actions/badge.svg)

# terraform-module-create_ansible_files_using_a_jumphost
Create an ansible inventory and a group_vars file, especially for when using a jumphost.

The ansible_inventory file is similar to the one from the [terraform-module-create_local_inventory_for_ansible](https://github.com:johanneskastl/terraform-module-create_local_inventory_for_ansible) terraform module, but:
- it has an support for two groups, one with floating IPs (think: jumphost) and one for instances without floating IPs.
- there is an additional group `only_via_jumphost` for instances without floating IPs
- the module will create a group_vars file (per default in `ansible/group_vars/only_via_jumphost/jumphost.yml`) to set the proper ssh options for ansible to use the jumphost
