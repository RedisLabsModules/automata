# ansible runner

This folder contains playbooks for configuring workloads. They run as standard ansible. Examples:

**Create a mongo server**
```
ansible-playbook -c local -i localhost, mongo.yml
```


**Initialize mongo servers, and then the cluster server**
```
ansible-playbook -c local -i server_ip_1,server_ip_2, mongo.yml
ansible-playbook -c local -i cluster_server_ip, mongo.yml -e mongo_cluster_host=1 -e "mongodb_nodes=['server_ip_1,server_ip_2]"
```
