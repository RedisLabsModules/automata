# ansible runner

This folder contains playbooks for configuring workloads. They run as standard ansible. Examples:

**Deploying against an existing workload**

In the example below, replacing the two variables will deploy the named playbook against a target server. [ansible-playbook](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html) supports multiple connection options for specifying ssh users, ssh keys, and other items. Given our use, case this is most frequently run with:

#### Useful ansible options

*  --private-key: for specifying the ssh key path

* -u <user>: for specifing the ssh user

* -K: to ensure we supply a sudo password, though that can be passed in as *-e ansible_sudo_pass=thepasswordforsudoing*

* --start-at-task="<task name>": Start from a specific ansible task.

* -e @file.yml: Load overrideable variables from a yaml file on disk named *file.yml*

```
ansible-playbook -i <ip address of your target>, <playbook>.yml -K
```

#### Role variables and overrides

In each case see roles/<rolename>/defaults/main.yml for the list of variables that can be specified or overridden. For example: roles/mongo/defaults/main.yml includes a mongo_inmemory variable, that if set will run mongodb and store all data in /dev/shm.

---------------------

#### Building faster, in a docker

For testing playbooks rapdily, running docksible.sh from the current directory is useful. It requires the playbook as a an arugment, though debugging in a vagrant continues to be much simpler. Note: if your service requires systemd, then at this time, running the playbook there is probably not useful.
