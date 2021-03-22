#!/usr/bin/env bash

BROKERID=$1
HOSTIP=$2
FIREWALLIP=213.65.195.170
KAFKA_VERSION=2.6.1
ZOOKEEPER_VERSION=3.6.2
ZOOKEEPER_DATA=/opt/zookeeper/data
KAFKA_DATA=/opt/kafka/data
ADVERTISED_PORT=$(( 9000 + ${BROKERID} ))

sudo apt update
sudo apt install default-jdk

sudo curl http://apache.mirrors.spacedump.net/kafka/${KAFKA_VERSION}/kafka_2.12-{$KAFKA_VERSION}.tgz --output /opt/kafka.tgz
sudo curl http://apache.mirrors.spacedump.net/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz --output /opt/zookeeper.tgz

cd /opt

sudo tar xfz zookeeper.tgz
sudo tar xfz kafka.tgz
sudo ln -s apache-zookeeper-${ZOOKEEPER_VERSION}-bin zookeeper
sudo ln -s kafka_2.12-${KAFKA_VERSION} kafka

sudo groupadd -g 600 zookeeper
sudo useradd -u 600 -g 600 zookeeper
sudo mkdir ${ZOOKEEPER_DATA}
sudo mkdir /opt/zookeeper/logs
sudo chown -R zookeeper:zookeeper /opt/zookeeper/*

cat > /tmp/zoo.cfg <<ZOO
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.
dataDir=${ZOOKEEPER_DATA}
# the port at which the clients will connect
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1

## Metrics Providers
#
# https://prometheus.io Metrics Exporter
#metricsProvider.className=org.apache.zookeeper.metrics.prometheus.PrometheusMetricsProvider
#metricsProvider.httpPort=7000
#metricsProvider.exportJvmInfo=true

4lw.commands.whitelist=stat,mntr,ruok

server.1=192.168.1.52:2888:3888
server.2=192.168.1.53:2888:3888
server.3=192.168.1.54:2888:3888
ZOO

cat > /tmp/zookeeper.service <<ZS

[Unit]
Description=ZooKeeper

[Service]
Type=simple
User=zookeeper
Group=zookeeper
ExecStart=/opt/zookeeper/bin/zkServer.sh start-foreground

TimeoutSec=300

[Install]
WantedBy=multi-user.target

ZS

echo ${BROKERID} | sudo -u zookeeper tee ${ZOOKEEPER_DATA}/myid
if [ -e /etc/kafka/server.properties.bak ]; then
  sudo rm /etc/kafka/server.properties.bak
fi
if [ -e /etc/kafka/server.properties ]; then
  sudo mv /etc/kafka/server.properties /etc/kafka/server.properties.bak
fi

sudo rm /opt/kafka.tgz /opt/zookeeper.tgz
sudo groupadd -g 601 kafka
sudo useradd -u 601 -g 601 kafka
sudo mkdir ${KAFKA_DATA}
sudo ln -s /opt/kafka/config /etc/kafka
if [ ! -d /var/log/kafka ]; then
  sudo mkdir /var/log/kafka
fi
sudo mkdir /opt/kafka/logs
sudo chown kafka:kafka /var/log/kafka
sudo chown -R kafka:kafka /opt/kafka*

cat > /tmp/kafka.service <<KS
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

[Unit]
Description=Kafka
Requires=network.target
After=network.target zookeeper.service

[Service]
User=kafka
Group=kafka
LimitNOFILE=32768:32768
Environment="KAFKA_HEAP_OPTS=-Xmx512m -Xms512m"
Environment="KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=192.168.1.52 -Djava.net.preferIPv4Stack=true"
Environment="JMX_PORT=8686"

ExecStart=/opt/kafka/bin/kafka-server-start.sh /etc/kafka/server.properties
Restart=on-failure

[Install]
WantedBy=multi-user.target
KS

cat > /tmp/server.properties <<KC

#
# (C) Copyright 2015 Hewlett Packard Enterprise Development Company LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#<E2><80><82> <E2><80><82> http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

############################# Server Basics #############################

# The id of the broker. This must be set to a unique integer for each broker.
broker.id=${BROKERID}

############################# Socket Server Settings #############################

# The port the socket server listens on
port=9092

# Hostname the broker will bind to. If not set, the server will bind to all interfaces
host.name=${HOSTIP}

# Hostname the broker will advertise to producers and consumers. If not set, it uses the
# value for "host.name" if configured.  Otherwise, it will use the value returned from
# java.net.InetAddress.getCanonicalHostName().
advertised.host.name=${FIREWALLIP}

# The port to publish to ZooKeeper for clients to use. If this is not set,
# it will publish the same port that the broker binds to.
advertised.port=${ADVERTISED_PORT}

# The number of threads handling network requests
num.network.threads=2

# The number of threads doing disk I/O
num.io.threads=2

# The send buffer (SO_SNDBUF) used by the socket server
socket.send.buffer.bytes=1048576

# The receive buffer (SO_RCVBUF) used by the socket server
socket.receive.buffer.bytes=1048576

# The maximum size of a request that the socket server will accept (protection against OOM)
socket.request.max.bytes=104857600


############################# Log Basics #############################

# A comma separated list of directories under which to store log files
log.dirs=${KAFKA_DATA}

auto.create.topics.enable=false
# The number of logical partitions per topic per server. More partitions allow greater parallelism
# for consumption, but also mean more files.
num.partitions=2

############################# Log Flush Policy #############################

# Messages are immediately written to the filesystem but by default we only fsync() to sync
# the OS cache lazily. The following configurations control the flush of data to disk.
# There are a few important trade-offs here:
#    1. Durability: Unflushed data may be lost if you are not using replication.
#    2. Latency: Very large flush intervals may lead to latency spikes when the flush does occur as there will be a lot of data to flush.
#    3. Throughput: The flush is generally the most expensive operation, and a small flush interval may lead to exceessive seeks.
# The settings below allow one to configure the flush policy to flush data after a period of time or
# every N messages (or both). This can be done globally and overridden on a per-topic basis.

# The number of messages to accept before forcing a flush of data to disk
log.flush.interval.messages=10000

# The maximum amount of time a message can sit in a log before we force a flush
log.flush.interval.ms=1000

############################# Log Retention Policy #############################

# The following configurations control the disposal of log segments. The policy can
# be set to delete segments after a period of time, or after a given size has accumulated.
# A segment will be deleted whenever *either* of these criteria are met. Deletion always happens
# from the end of the log.

# The minimum age of a log file to be eligible for deletion
log.retention.hours=72

# A size-based retention policy for logs. Segments are pruned from the log as long as the remaining
# segments don't drop below log.retention.bytes.
log.retention.bytes=5368709120

# The maximum size of a log segment file. When this size is reached a new log segment will be created.
log.segment.bytes=104857600

# The interval at which log segments are checked to see if they can be deleted according
# to the retention policies
log.retention.check.interval.ms=60000

# By default the log cleaner is disabled and the log retention policy will default to just delete segments after their retention expires.
# If log.cleaner.enable=true is set the cleaner will be enabled and individual logs can then be marked for log compaction.
log.cleaner.enable=true

############################# Zookeeper #############################

# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
zookeeper.connect=192.168.1.52:2181,192.168.1.53:2181,192.168.1.54:2181

# Timeout in ms for connecting to zookeeper
zookeeper.connection.timeout.ms=1000000

# Offsets older than this retention period will be discarded (20160 minutes = 14 days)
# The default is 1 day, which may result in messages being lost if a consumer is terminated and not restarted in
# time.
offsets.retention.minutes=20160

KC

echo "Fixing config..."

sudo -u zookeeper cp /tmp/zoo.cfg /opt/zookeeper/conf
sudo cp /tmp/zookeeper.service /etc/systemd/system
sudo cp /tmp/kafka.service /etc/systemd/system
sudo cp /tmp/server.properties /etc/kafka/

sudo systemctl daemon-reload
