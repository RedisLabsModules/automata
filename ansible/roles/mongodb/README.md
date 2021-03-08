# mongodb

This role provides basic support for installing a mongodb server, or cluster.


## Building a Cluster

1. Build the secondary nodes as regular mongo servers.
1. Building the server and  initializing it as a cluster master.
    1.  Specify *mongo_cluster_host* when building the host.
    2. Specify the IP addresses of the mongo nodes when building the master as *mongodb_nodes*.