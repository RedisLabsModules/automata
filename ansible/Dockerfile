FROM ubuntu:20.04 as basebox

RUN apt update && apt upgrade -y
RUN apt install -y python3 python3-pip
RUN pip3 install ansible

#---------------------------------------#

FROM basebox

ARG PLAYBOOK=default.yml
ADD . /build
WORKDIR /build
RUN echo ansible-playbook -c local -i localhost, ${PLAYBOOK}
RUN ansible-playbook -c local -i localhost, ${PLAYBOOK}
