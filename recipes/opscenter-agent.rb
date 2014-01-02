#
# Cookbook Name:: dse-chef
# Recipe:: opscenter-agent
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

execute 'install opscenter-agent' do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
    tar -xvf #{agent_file}
    cd agent
    bin/install_agent.sh #{'-s' if node[:datastax][:opscenter][:use_ssl]} datastax-agent.deb #{node[:datastax][:opscenter][:host]}
  EOF
  not_if { ::File.exists?('/usr/share/datastax-agent/bin/datastax-agent') }
  notifies :restart, 'service[datastax-agent]', :delayed
end

service 'datastax-agent' do
  supports :restart => true, :start => true, :stop => true
  action [:enable]
  ignore_failure true
end