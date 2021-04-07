# mongodb

This role provides basic support for installing a mongodb server, or cluster.


## Building a Cluster

1. Build the secondary nodes first, without specifying any extra configuration.
1. Build the cluster master second, initializing it with the following:
    1. Specify *mongo_cluster_host* when building the host.
    2. Specify the IP addresses of the mongo nodes when building the master as *mongodb_nodes*. In our example below, we'll assume that the node joining the cluster has the IP address of *192.168.1.111*

**eg: Adding a single node while building a cluster master**
```
ansible-playbook ...<normal options>... -e mongo_cluster_host=1 -e mongodb_nodes=192.168.1.111
```

**eg: Adding multiple nodes while building a cluster master**

Note: when building a cluster master, and adding hosts to it, those hosts must be reachable by the master, at build time.

```
ansible-playbook ...<normal options>... -e mongo_cluster_host=1 -e '{mongodb_nodes: [192.168.1.111,192.168.2.222,192.168.3.113]}'
```

**Manually adding notes to a cluster**

Finally, to manually add hosts to an existing cluster after-the-fact execute the command below, replacing the IP address in the comand, with the desired IP address.

```mongo --eval 'rs.add("192.168.1.111")'
```