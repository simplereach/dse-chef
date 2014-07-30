#
# Cookbook Name:: dse-chef
# Recipe:: install
# Author:: Russell Bradberry <rbradberry@simplereach.com>
# Author:: Eric Lubow <elubow@simplereach.com>
#
# Installs or updates DSE
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

# NUMA is good and should be installed on Cassandra
package 'numactl' do
  action :install
end

# grab the dse password information
dse = data_bag_item('keys', 'datastax')

apt_repository 'dse' do
  uri "http://#{dse['user']}:#{dse['password']}@debian.datastax.com/enterprise"
  key 'http://debian.datastax.com/debian/repo_key'
  components %w(main)
  distribution 'stable'
end

full_version = node[:datastax][:dse][:versions][:full]
node[:datastax][:dse][:versions].each do |pkg, ver|
  pkg_version = ver.nil? ? full_version : ver

  apt_preference "dse-#{pkg.to_s}" do
    pin "version #{pkg_version}"
    pin_priority '1001'
  end
end

base_version = node[:datastax][:dse][:versions][:base].nil? ? full_version : node[:datastax][:dse][:versions][:base]
apt_preference "dse" do
  pin "version #{base_version}"
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
