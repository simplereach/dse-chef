#
# Cookbook Name:: dse-chef
# Attributes:: default
# Author:: Russ Bradberry <rbradberry@simplereach.com>
# Author:: Eric Lubow <elubow@simplereach.com>
#
# Description:: DSE default attributes
#

default[:datastax][:dse][:versions][:full] = '4.5.0-1'

default[:datastax][:dse][:hadoop_enabled] = false
default[:datastax][:dse][:spark_enabled] = false
default[:datastax][:dse][:solr_enabled] = false
default[:datastax][:dse][:extra_classpath] = nil
default[:datastax][:dse][:cfs_replication_factor] = 1
default[:datastax][:dse][:dse_home] = '/usr/share/dse'
default[:datastax][:dse][:output_file] = '/var/log/cassandra/output.log'
default[:datastax][:dse][:conf_dir] = '/etc/dse/cassandra'
default[:datastax][:dse][:pid_file] = '/var/run/$NAME/$NAME.pid'


default[:datastax][:opscenter][:host] = '127.0.0.1' #IP Address to point the opscenter agent at
default[:datastax][:opscenter][:version] = '4.1.4-1'  #Opscenter version
default[:datastax][:opscenter][:use_ssl] = true     #Agent SSL Communication
default[:datastax][:opscenter][:agent_tarball_location] = nil #Tarball location for agent

# Default versions
# we list out all the verions here to ensure that Debian/Ubuntu based package management
# can downgrade properly
default[:datastax][:dse][:versions][:base] = nil
default[:datastax][:dse][:versions][:hive] = nil
default[:datastax][:dse][:versions][:libhive] = nil
default[:datastax][:dse][:versions][:pig] = nil
default[:datastax][:dse][:versions][:libpig] = nil
default[:datastax][:dse][:versions][:demos] = nil
default[:datastax][:dse][:versions][:libsolr] = nil
default[:datastax][:dse][:versions][:libtomcat] = nil
default[:datastax][:dse][:versions][:libsqoop] = nil
default[:datastax][:dse][:versions][:liblog4j] = nil
default[:datastax][:dse][:versions][:libmahout] = nil
default[:datastax][:dse][:versions][:libcassandra] = nil
default[:datastax][:dse][:versions][:libhadoop] = nil
default[:datastax][:dse][:versions][:'libhadoop-native'] = nil

