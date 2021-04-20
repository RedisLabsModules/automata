# A build system for dockers images

Dockers need to be built, and used for a build system to function. Ultimately we want to have a series of known, baseline docker images, run *system-setup* against them, and publish new dockers on an as-needed basis.  The question is where.

## Rules of Engagement

1. Docker images are built from base docker files, located in this directory.

1. Docker images are published to *redisfab* in dockerhub.

### Naming convention

Docker images will be named *baseos-architecture-suffix-(optional special purpose)*. The only caveat is that baseos will be alphanumeric and lowercase.

1. ubuntu1804-arm64-bazel3.1.0-jetson  # this is an arm docker for a jetson device, with bazel3.1.0 based on ubuntu 18.04

1. ubuntu1804-x86_64-bazel3.1.0  # this is a docker for a x86_64 hardware, with bazel3.1.0.

### Building and deploying

Run your builds from the root of the repo, as the dockers likely make use of readies, which is in deps/readies.

**example**

docker build -f dockers/buildsystem/Dockerfile.bazel -t redisfab/ubuntu1804-x86_64-bazel3.1.0:latest .
docker push redisfab/ubuntu1804-x86_64-bazel3.1.0
