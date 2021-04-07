# ansible runner

This folder contains playbooks for configuring workloads. They run as standard ansible. Examples:

**Deploying against an existing workload**

In the example below, replacing the two variables will deploy the named playbook against a target server. [ansible-playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html) supports multiple connection options for specifying ssh users, ssh keys, and other items. Given our use, case this is most frequently run with:

#### Useful ansible options

*  --private-key: for specifying the ssh key path

* -u <user>: for specifing the ssh user

* -K: to ensure we supply a sudo password, though that can be passed in as *-e ansible_sudo_pass=thepasswordforsudoing*

* --start-at-task="<task name>": Start from a specific ansible task.

```
ansible-playbook -i <ip address of your target>, <playbook>.yml -K
```


**Example: Initialize mongo servers, and then the cluster server**
```
ansible-playbook -i server_ip_1,server_ip_2, mongo.yml
ansible-playbook -i cluster_server_ip, mongo.yml -e mongo_cluster_host=1 -e "mongodb_nodes=['server_ip_1,server_ip_2]"
```

---------------------

#### Building faster, in a docker

For testing playbooks rapdily, running docksible.sh from the current directory is useful. It requires the playbook (i.e mongodb.yml) as a an arugment, though debugging in a vagrant continues to be much simpler.
