#
# Cookbook Name:: dse-chef
# Attributes:: jvm
# Author:: Russ Bradberry <rbradberry@simplereach.com>
#
# Description:: JVM default attributes
#

# Override these to set the amount of memory to allocate to the JVM at
# start-up. For production use you may wish to adjust this for your
# environment. MAX_HEAP_SIZE is the total amount of memory dedicated
# to the Java heap; HEAP_NEWSIZE refers to the size of the young
# generation. Both MAX_HEAP_SIZE and HEAP_NEWSIZE should be either set
# or not (if you set one, set the other).
#
# The main trade-off for the young generation is that the larger it
# is, the longer GC pause times will be. The shorter it is, the more
# expensive GC will be (usually).
#
# The example HEAP_NEWSIZE assumes a modern 8-core+ machine for decent pause
# times. If in doubt, and if you do not particularly want to tweak, go with
# 100 MB per physical CPU core.

default[:datastax][:jvm][:max_heap_size] = nil # 8G
default[:datastax][:jvm][:heap_new_size] = nil # 800M

# Specifies the default port over which Cassandra will be available for
# JMX connections.
default[:datastax][:jvm][:jmx_port] = 7199

# The per thread stack size, increase this to 190k if you are getting any StackOverflow errors on startup
default[:datastax][:jvm][:per_thread_stack_size] = '180k'

# Extra JVM Opts
default[:datastax][:jvm][:jvm_extra_opts] = nil

# Set this if you have trouble connecting to JMX
default[:datastax][:jvm][:public_name] = nil
