# create from template

data "template_file" "group_vars_file_template" {
  template = <<EOT
# Jumphost user is: ${var.jumphost_user}
# Jumphost floating IP is ${tostring(var.jumphost_instanceobject.floating_ips[0].address)}
ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q ${var.jumphost_user}@${tostring(var.jumphost_instanceobject.floating_ips[0].address)}"'
EOT
}

resource "local_file" "group_vars_file" {
  content         = data.template_file.group_vars_file_template.rendered
  filename        = var.group_vars_file_name_with_path
  file_permission = var.group_vars_file_permissions
}
