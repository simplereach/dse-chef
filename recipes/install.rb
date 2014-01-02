#
# Cookbook Name:: dse-chef
# Recipe:: install
# Author:: Russell Bradberry <rbradberry@simplereach.com>
# Author:: Eric Lubow <elubow@simplereach.com>
#
# Installs or updates DSE
#
# Copyright 2013, SimpleReach
#
# dse requires oracle/sun java, good to put this here

#Set some Java defaults
node.default[:java][:install_flavor] = 'oracle'
node.default[:java][:oracle][:accept_oracle_download_terms] = true
node.default[:java][:jdk_version] = 7


# include the required resources
include_recipe 'java'

package 'libjna-java' do
  action :install
end

# grab the dse password information
dse = data_bag_item('keys', 'datastax')

apt_repository 'dse' do
  uri "http://#{dse['user']}:#{dse['password']}@debian.datastax.com/enterprise"
  key 'https://debian.datastax.com/debian/repo_key'
  components %w(main)
  distribution 'stable'
end

node[:datastax][:dse][:versions].each do |pkg, ver|
  apt_preference "dse-#{pkg.to_s}" do
    pin "version #{ver}"
    pin_priority '1001'
  end
end

apt_preference "dse" do
  pin "version #{node[:datastax][:dse][:versions][:base]}"
  pin_priority '1001'
end

package 'dse-full' do
  version node[:datastax][:dse][:versions][:full]
  action :install
  options '-o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"'
end

service 'dse' do
  supports :restart => true, :start => true, :stop => true
  action [:enable]
  ignore_failure true
end
