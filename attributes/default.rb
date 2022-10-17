default['honeycomb']['writekey'] = "REPLACE_ME"
default['honeycomb']['api_url'] = "https://api.honeycomb.io"
default['honeycomb']['dataset'] = "chefruns"

# Used to generate a link to chef-run information in Automate
# default['honeycomb']['automate_fqdn'] = "automate.example.com"

# Custom node attributes you want to add as attributes to events for your query-building desires
default['honeycomb']['tracked_attributes'] = {
  # 'chef.node.example' => node['example'],
  # 'chef.node.other.example.attribute' => node['other']['example']['attribute'],
}

######################################################################
# Be advised that this hanlder tracks several node objects by default
#   so you don't need to add them above.  See the list below:
######################################################################
# node['name']
# node['chef_guid']
# node['chef_packages']['chef']['version']
# node['chef_packages']['ohai']['version']
# node['os']
# node['os_version']
# node['platform']
# node['platform_family']
# node['platform_version']
# node['kernel']['processor']
# node['ipaddress']
# node['hostname']
# node['machinename']
# node['fqdn']
# node['cloud']
# node['chef_environment']
# node['policy_name']
# node['policy_group']
# node['policy_revision']
# node['roles']
######################################################################
