#!/bin/sh

if [ -z $1 ]; then
    echo "No playbook (foo.yml) specified"
    exit 1
fi

if [ ! -f $1 ]; then
    echo "$1 does not exist."
    exit 1
fi

if [ -z $DOCKERNAME ]; then
    DOCKERNAME=ansibledocker
fi

docker run -v `pwd`:/ansible:ro --rm --name $DOCKERNAME ubuntu:20.04 /bin/bash -c "cd /ansible; apt update -yqq; apt-get install -yqq python ansible; ansible-playbook -c local -i localhost, -e ansible_in_docker=1 $1 $*"
