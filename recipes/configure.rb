#
# Cookbook Name:: dse-chef
# Recipe:: configure
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Description:: Sets up configuration files for DSE
#


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

#We don't want to notify restart on these templates as we want to
#allow the user to rolling restart their cluster on config changes
template '/etc/dse/cassandra/cassandra.yaml' do
  owner 'root'
  group 'root'
  mode '0755'
  source 'cassandra.yaml.erb'
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
  source 'dse.erb'
end

