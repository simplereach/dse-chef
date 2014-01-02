#
# Cookbook Name:: dse-chef
# Recipe:: aws_raid
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Description:: Sets up the RAID for Cassandra data
#


package 'mdadm' do
  action :install
end

package 'xfsprogs' do
  action :install
end

mount "/mnt" do
  device "/dev/xvdb"
 action [:umount, :disable]
end

#Create a Raid Volume from the 4 Given.
mdadm '/dev/md127' do
  devices node.ec2.select{|k,v| k.match(/block_device_mapping_ephemeral\d/) }.map{|k,v| "/dev/#{v}" }
  level 0
  chunk 64
  action [ :create, :assemble ]
end

#Format it as xfs if it isn't already
execute 'xfs_md127' do
  command 'mkfs.xfs -f /dev/md127'
  only_if 'xfs_admin -l /dev/md127 2>&1 | grep -qx \'xfs_admin: /dev/md127 is not a valid XFS filesystem (unexpected SB magic number 0x00000000)\''
end

# Create the mount point
directory '/raid0' do
  action :create
  user 'root'
  mode '0755'
end

#Mount the volume
mount '/raid0' do
  device '/dev/md127'
  fstype 'xfs'
  pass 0
  options 'defaults,nobootwait,noatime'
  action [:mount, :enable]
end
