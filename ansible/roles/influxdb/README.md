# influxdb

This role provides basic support for installing a influxdb server.

# Building a cluster

1. Build the first node. It will be the master node of the cluster.
2. Build the secondary nodes and set the *influxdb_master_ip* variable to be the ip address of the master node using ANSIBLE_EXTRA_VARS="-e influxdb_master_ip=<IP1>"
