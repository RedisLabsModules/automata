#!/usr/bin/env python

# A helper tool for generating docker-compose files

import os
import sys
from optparse import OptionParser
import jinja2

if __name__ == '__main__':

    p = OptionParser()
    p.add_option('-o', '--outfile', dest='OUTFILE', help="Output filename, defaults to docker-compose.yml", default="docker-compose.yml")
    p.add_option('-d', '--dockerimage', dest='DOCKERIMAGE', action="append", help="Docker image")
    p.add_option('-x', '--debug', dest='DEBUG', help="Set, to print to console", action='store_true')
    p.add_option('-m', '--mount', dest='MOUNT', help="Set, to specify a filesystem to mount in the docker")
    p.add_option('-M', '--mount-dest', dest='MOUNTDEST', help="Set, to specify the destination in the docker, defaults to /build", default="/build")
    opts, args = p.parse_args()

    if not opts.DOCKERIMAGE:
        sys.stderr.write("No docker images specified.\n")
        sys.exit(3)

    tmpl = """
version: "3.9"
services:
    {% for d in dockers %}
  {{d|replace(".", "")|replace("/","")|replace(":","")}}:
    image: {{d}}
    container_name: stitch.{{d|replace(".","")|replace("/","")|replace(":","")}}
    restart: unless-stopped
    logging:
      driver: "none"
    entrypoint: tail -f /dev/null
    environment:
      - LANG=C.UTF-8
      - LC_ALL=C.UTF-8
    {% if mount is not none %}
    volumes:
      - {{mount}}:{{dest}}
    {% endif %}
    {% endfor %}
"""

    if not opts and not args:
        parser.print_help()
        sys.exit(1)

    if opts.MOUNT is not None:
        opts.MOUNT = os.path.abspath(opts.MOUNT)
    context = {"dockers": opts.DOCKERIMAGE, "mount": opts.MOUNT, "dest": opts.MOUNTDEST}
    t = jinja2.Template(tmpl)
    if opts.DEBUG:
        sys.stderr.write(t.render(context) + "\n")
    else:
        with open(opts.OUTFILE, 'w+') as fp:
            fp.write(t.render(context))
