#
# Cookbook Name:: dse-chef
# Recipe:: opscenter-server
# Author:: Opsline
#
# Copyright 2013, SimpleReach
#
# All rights reserved - Do Not Redistribute
#

apt_repository 'datastax' do
  uri node[:datastax][:opscenter][:debian_apt_url]
  components ['stable', 'main']
  key 'http://debian.datastax.com/debian/repo_key'
end

package 'opscenter' do
  action :install
  version node[:datastax][:opscenter][:server_version]
end

directory '/etc/opscenter/clusters' do
  action :create
  owner 'root'
  group 'root'
  mode 0755
end

node[:datastax][:opscenter]['clusters'].each do |cluster_name, cluster_config|
  template "/etc/opscenter/clusters/#{cluster_name}.conf" do
    action :create
    source 'opscenter-cluster-config.conf.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables({
      :name => cluster_name,
      :config => cluster_config
    })
  end
end

service 'opscenterd' do
  action [:start, :enable]
end

include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_proxy_http'

template "#{node['apache']['dir']}/sites-available/opscenter.conf" do
  source 'opscenter-apache-proxy.conf.erb'
  mode '0644'
  variables(
    :server_name => 'opscenter.aws.simplereach.com',
  )
  if File.symlink?("#{node['apache']['dir']}/sites-enabled/opscenter.conf")
    notifies :reload, 'service[apache2]'
  end
end

apache_site 'opscenter'
