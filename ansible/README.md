# ansible runner

This folder contains playbooks for configuring workloads. They run as standard ansible. Examples:

**Create a mongo server**
```
ansible-playbook -c local -i localhost, mongo.yml
```


**Initialize mongo servers, and then the cluster server**
```
ansible-playbook -i server_ip_1,server_ip_2, mongo.yml
ansible-playbook -i cluster_server_ip, mongo.yml -e mongo_cluster_host=1 -e "mongodb_nodes=['server_ip_1,server_ip_2]"
```

---------------------

#### Useful ansible options

-K: ansible will ask you for a sudo password

--start-at-task="<task name>": Start from a specific ansible task.

-----------------------

#### Building with the local dockerfile

As a small hack, there's a Dockerfile within this directory. In theory one can build and run any playbook by running the following command:

```
docker built --build-arg PLAYBOOK=someplaybook.yml .
```

Using the above example _someplaybook.yml_ would be replaced with _mongodb.yml_ to test the mongodb.yml ansible playbook. Note: given how dockers work, one probably has to disable the calls to systctl in various roles.
