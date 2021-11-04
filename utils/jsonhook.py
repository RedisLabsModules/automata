#!/usr/bin/env python

# A quick script for sending notifications to Slack when the content of a URL changes.

import requests
import hashlib
import json
import os

WEBHOOK_URL="https://placeholder"

def fetch_and_hash(url):
    r = requests.get(url)
    if r.status_code != 200:
        return ""

    h = hashlib.sha1()
    h.update(r.content)
    return h.hexdigest()

def slackify(u):
    repo = u.split("/")[4]
    head = u.replace("raw.githubusercontent.com", "github.com")+"#HEAD"
    msg = """The commands.json for {} were just updated in GitHub. See {}""".format(repo, u)
    slack_data = {"text": msg}
    r = requests.post(WEBHOOK_URL, json.dumps(slack_data), headers="Content-Type": "application/json"})

# link to raw commands.json
urls = [
    "https://raw.githubusercontent.com/redis/redis-doc/master/commands.json",
    "https://raw.githubusercontent.com/RedisAI/RedisAI/master/commands.json",
    "https://raw.githubusercontent.com/RedisJSON/RedisJSON/master/commands.json",
    "https://raw.githubusercontent.com/RediSearch/RediSearch/master/commands.json",
    "https://raw.githubusercontent.com/RedisBloom/RedisBloom/master/commands.json",
    "https://raw.githubusercontent.com/RedisGraph/RedisGraph/master/commands.json",
    "https://raw.githubusercontent.com/RedisTimeSeries/RedisTimeSeries/master/commands.json",
]

destfile = "cache.json"
if os.path.isfile(destfile):
    try:
        content = json.loads(open(destfile).read())
    except:
        content = {}
else:
    content = {}

for u in urls:
    sha1 = fetch_and_hash(u)
    if sha1 != content.get(u, ""):
        slackify(u)
        content[u] = sha1

with open(destfile, "w+") as fp:
    fp.write(json.dumps(content))
