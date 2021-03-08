# automaton

This repository contains the code used to build a variety of platforms.

-----------------

### Contributing

The *master branch* is sacrosanct, anything in master should work. To contribute, file an issue and create a pull request linked to the requisite issue. Pull requests without issues will be summarily closed.

### Tooling

[poetry](https://python-poetry.org/) manages dependencies, and specifies the python version used by this project. poetry can be used to manage python virtualenvs, but managing versions ofl python is left to the contributor - though we rely on [pyenv](https://github.com/pyenv/pyenv), for ensuring a minimum verison.

Workload configurations are validated in [vagrant](https://www.vagrantup.com/), using the [VirtualBox](https://www.virtualbox.org) provisioner. [ansible](https://www.ansible.com) specifies workload contents.

#### Workflow

If you don't already have this version of python available:

```
pyenv install `cat .python-version`
pip install poetry
poetry install
```
