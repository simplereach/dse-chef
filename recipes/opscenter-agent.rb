#
# Cookbook Name:: dse-chef
# Recipe:: opscenter-agent
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Sets up configuration files for DSE
#
# Copyright 2013, SimpleReach
#
# All rights reserved - Do Not Redistribute
#
agent_file = "datastax-agent-#{node[:datastax][:opscenter][:version]}.tar.gz"
agent_path = "#{Chef::Config[:file_cache_path]}/#{agent_file}"
remote_file agent_path do
  action :create_if_missing
  source node[:datastax][:opscenter][:agent_tarball_location]
end

server_role = node[:datastax][:opscenter][:server_role]

opscenter_hosts = search(:node, "roles:#{server_role} AND chef_environment:#{node.chef_environment}")
if opscenter_hosts.length == 0
  Chef::Log.warn("Could not find any opscenter servers. Skipping agent configuration.")
  return
elsif opscenter_hosts.length > 1
  Chef::Log.warn("Found too many opscenter servers. Skipping agent configuration.")
  return
else
  opscenter_host = opscenter_hosts[0].ipaddress
end

execute 'install opscenter-agent' do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
    tar -xvf #{agent_file}
    cd agent
    bin/install_agent.sh #{'-s' if node[:datastax][:opscenter][:use_ssl]} datastax-agent.deb #{opscenter_host}
  EOF
  not_if { ::File.exists?('/usr/share/datastax-agent/bin/datastax-agent') }
  notifies :restart, 'service[datastax-agent]', :delayed
end

service 'datastax-agent' do
  supports :restart => true, :start => true, :stop => true
  action [:enable]
  ignore_failure true
end

template '/var/lib/datastax-agent/conf/address.yaml' do
  action :create
  source 'address.yaml.erb'
  owner 'opscenter-agent'
  group 'opscenter-agent'
  mode 0644
  variables({
    :stomp_interface => opscenter_host
  })
  notifies :restart, 'service[datastax-agent]', :delayed
end
