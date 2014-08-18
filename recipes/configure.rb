#
# Cookbook Name:: dse-chef
# Recipe:: configure
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Description:: Sets up configuration files for DSE
#

chef_gem 'semantic'
require 'semantic'

if node[:datastax][:dse][:versions][:libcassandra].nil?
  version = Semantic::Version.new(node[:datastax][:dse][:versions][:full])
else
  version = Semantic::Version.new(node[:datastax][:dse][:versions][:libcassandra])
end

if version < Semantic::Version.new('4.0.0')
  yaml_source = 'cassandra-1.2.yaml.erb'
elsif version < Semantic::Version.new('4.5.0')
  yaml_source = 'cassandra-2.0.yaml.erb'
end

directory node[:datastax][:cassandra][:saved_caches_directory] do
  owner 'cassandra'
  group 'cassandra'
  mode '0755'
  recursive true
end

directory node[:datastax][:cassandra][:data_file_directories] do
  owner 'cassandra'
  group 'cassandra'
  mode '0755'
  recursive true
end

directory node[:datastax][:cassandra][:commitlog_directory] do
  owner 'cassandra'
  group 'cassandra'
  mode '0755'
  recursive true
end

directory '/var/run/dse' do
  owner 'cassandra'
  group 'cassandra'
  mode '0744'
  recursive true
end

#We don't want to notify restart on these templates as we want to
#allow the user to rolling restart their cluster on config changes
template '/etc/dse/cassandra/cassandra.yaml' do
  owner 'root'
  group 'root'
  mode '0755'
  source yaml_source
end

template '/etc/dse/cassandra/cassandra-env.sh' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'cassandra-env.sh.erb'
end

template '/etc/default/dse' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'dse.default.erb'
end

# for some reason Datastax set's a file descriptor limit of 100k for Cassandra,
# this needs to be changed and it's easier to replace the file
template '/etc/init.d/dse' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'dse.init.erb'
end
