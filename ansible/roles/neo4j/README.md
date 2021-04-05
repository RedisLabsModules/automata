# neo4j

This role provides basic support for installing neo4j.

## Options

**Installing enterprise**: To install the enterprise version of neo4j, define a *neo4j_enterprise* variable, by running ansible with -e neo4j\_enterprise=1

**Storing data in memory**: Like other roles, data can be stored in memory on the neo4j node by running ansible with a -e neo4j_inmemory=1 variable defined.

**Building a cluster**: Building a neo4j cluster involves building all nodes, and passing in an argument for the various cluster hosts.  Hosts are passed in as a comma delimited list using the format ip:port as per the example below:

1. -e neo4j_cluster_hosts=1.2.3.4:5000,5.5.6.6:5000,192.168.1.111:5000.

Note - you can use DNS names rather than IP addresses. Similarly, the list of **neo4j_cluster_hosts** can contain all hosts in the cluster, including the host being run on.  This gives the added advantage that when building neo4j clusters specifically, a single inventory can be used. Here's a command example - to be run from the root ansible directory, using the IP addresses above.

ansible-playbook -i 1.2.3.4,5.5.6.6,192.168.1.111, -e neo4j_cluster_hosts=1.2.3.4:5000,5.5.6.6:5000,192.168.1.111:5000 neo4j.yml