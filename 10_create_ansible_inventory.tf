# create ansible_inventory from template

data "template_file" "ansible_inventory_template" {
  template = <<EOT
%{for group in var.groups_with_floating_ips~}
[${group.name}]
%{for fip_association in group.instancesobject.floating_ip_associations.*~}
%{for host in group.instancesobject.instances.*~}
%{if host.id == fip_association.instance_id~}
${host.name} ansible_user=${group.user_for_ansible} ansible_host=${fip_association.floating_ip} external_ip=${fip_association.floating_ip} internal_ip=${host.network[0].fixed_ip_v4}
%{endif~}
%{endfor~}
%{endfor~}

%{endfor~}
%{for group in var.groups_without_floating_ips~}
[${group.name}]
%{for host in group.instancesobject.instances.*~}
${host.name} ansible_user=${group.user_for_ansible} ansible_host=${host.network[0].fixed_ip_v4} internal_ip=${host.network[0].fixed_ip_v4}
%{endfor~}

%{endfor~}

[only_via_jumphost]
%{for group in var.groups_without_floating_ips~}
%{for host in group.instancesobject.instances.*~}
${host.name} ansible_user=${group.user_for_ansible} ansible_host=${host.network[0].fixed_ip_v4} internal_ip=${host.network[0].fixed_ip_v4}
%{endfor~}
%{endfor~}
EOT
}

resource "local_file" "ansible_inventory" {
  content         = data.template_file.ansible_inventory_template.rendered
  filename        = var.inventory_file_name_with_path
  file_permission = var.inventory_file_permissions
}
