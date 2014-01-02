#
# Cookbook Name:: dse-chef
# Attributes:: default
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Description:: DSE default attributes
#

default[:datastax][:dse][:versions][:full] = '3.2.1-1'

default[:datastax][:dse][:hadoop_enabled] = false
default[:datastax][:dse][:solr_enabled] = false
default[:datastax][:dse][:extra_classpath] = nil
default[:datastax][:dse][:cfs_replication_factor] = 1


default[:datastax][:opscenter][:host] = '127.0.0.1' #IP Address to point the opscenter agent at
default[:datastax][:opscenter][:version] = '4.0.0-1'  #Opscenter version
default[:datastax][:opscenter][:use_ssl] = true     #Agent SSL Communication
default[:datastax][:opscenter][:agent_tarball_location] = nil #Tarball location for agent

# Default versions
default[:datastax][:dse][:versions][:base] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:hive] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libhive] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:pig] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libpig] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:demos] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libsolr] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libtomcat] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libsqoop] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:liblog4j] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libmahout] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libcassandra] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:libhadoop] = default[:datastax][:dse][:versions][:full]
default[:datastax][:dse][:versions][:'libhadoop-native'] = default[:datastax][:dse][:versions][:full]


