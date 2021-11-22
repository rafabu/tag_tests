variable "group_name_suffixes" {
  type        = list
  description = "tg resource object for which AD groups have to be created"
}
module "name" {
  source                     = "../../../../internal/terraform/azland_resourcename"
  resource_type              = "azuread_group"
  resource_name_fixedname    = "<resourcenamepart>"
  resource_name_randomsuffix = false
}
resource "azuread_group" "group" {
  for_each = toset(var.group_name_suffixes)
  name     = replace(module.name.resource_name, "<resourcenamepart>", each.key)
}

output "resources" {
  value = length(azuread_group.group) > 0 ? azuread_group.group : null
}
