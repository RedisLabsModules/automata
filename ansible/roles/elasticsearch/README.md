## Running an elastic cluster with extra vars

There's a limitation in how clusters are built. Specifically, the ansible inventory name must match the IP address of the hosts used in the cluster.

The practical result means that the cluster is built with all nodes at once, and the inventory (-i) must contain the same IP addresses or host names, as the elasticsearch\_nodes listed below (again, notice the comma).

-i 192.168.1.111,192.168.2.222,192.168.3.113, -e '{elasticsearch_nodes: [192.168.1.111,192.168.2.222,192.168.3.113]}'

### Testing in a Vagrant

If you're validating clusters in a vagrant, this means that the default (automated) deployment cannot be used, and instead either the public IP must be passed, or the hostname/IP solution solved.  Ideally the ansible-playbook call would not happen on localhost.
