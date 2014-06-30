#
# Cookbook Name:: dse-chef
# Attributes:: cassandra
# Author:: Eric Lubow <elubow@simplereach.com>
#
# Description:: Spark default attributes
#

default[:datastax][:dse][:spark][:master_port] = 7077
default[:datastax][:dse][:spark][:master_webui_port] = 7080
default[:datastax][:dse][:spark][:worker_webui_port] = 7081

# mandatory variables
default[:datastax][:dse][:spark][:mesos_native_library] = "/usr/share/dse/spark/lib"
default[:datastax][:dse][:spark][:scala_home] = "/usr/share/dse/shark/lib"

# By default, Spark Worker uses nearly all available resources in the system
default[:datastax][:dse][:spark][:worker_memory] = "4g"
default[:datastax][:dse][:spark][:mem] = "2g"
default[:datastax][:dse][:spark][:repl_mem] = "2g"

# directories
default[:datastax][:dse][:spark][:tmp_dir] = "$SPARK_HOME/tmp"
default[:datastax][:dse][:spark][:logs_dir] = "$SPARK_HOME/logs"
default[:datastax][:dse][:spark][:worker_dir] = "$SPARK_HOME/work"

# various options
default[:datastax][:dse][:spark][:common_opts] = "-Dspark.kryoserializer.buffer.mb=10"
default[:datastax][:dse][:spark][:master_opts] = "-Dspark.deploy.defaultCores=1 -Dspark.local.dir=$SPARK_TMP_DIR/master -Dlog4j.configuration=file://$SPARK_CONF_DIR/log4j-server.properties -Dspark.log.file=$SPARK_LOG_DIR/master.log"
default[:datastax][:dse][:spark][:worker_opts] = "-Dspark.local.dir=$SPARK_TMP_DIR/worker -Dlog4j.configuration=file://$SPARK_CONF_DIR/log4j-server.properties -Dspark.log.file=$SPARK_LOG_DIR/worker.log"
default[:datastax][:dse][:spark][:executor_opts] = "-Djava.io.tmpdir=$SPARK_TMP_DIR/executor -Dlog4j.configuration=file://$SPARK_CONF_DIR/log4j-executor.properties"
default[:datastax][:dse][:spark][:repl_opts] = "-Djava.io.tmpdir=$SPARK_TMP_DIR/repl/$USER"
default[:datastax][:dse][:spark][:app_opts] = "-Djava.io.tmpdir=$SPARK_TMP_DIR/app/$USER"
