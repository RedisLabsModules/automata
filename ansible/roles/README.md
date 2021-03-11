# roles

Ansible roles should follow the module standards. Default variables are defined in <role>/defaults/main.yml and can be overridden for testing on the command-line by passing *-e <variable>=value*, or by overriding the variable in an ansible playbook.

When configuring in-memory storage for a role that supports it, we've settled on the standard <role>\_inmemory as a boolean default value.  For example: elasticsearch\_inmemory and mongo\_inmemory, both of which are set to false, by default.
