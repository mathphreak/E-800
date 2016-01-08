#!/usr/bin/env python
import psycopg2
import hashlib
import docker
import pystache
import os
import sys
import ast
import shutil

conn = psycopg2.connect("host=db dbname=postgres user=postgres")
conn.autocommit = True
cur = conn.cursor()
cur.execute("""
    SELECT submissions.id, submissions.code, assignments.run_script
    FROM submissions
    LEFT JOIN assignments
        ON submissions.assignment_id = assignments.id
    WHERE submissions.pending;
""")
if cur.rowcount is 0:
    print "Nothing is pending"
    sys.exit(0)
(id, code, script) = cur.fetchone()
cur.close()

m = hashlib.md5()
m.update(str(id))
m.update(code)
m.update(script)
subdir = m.hexdigest()

try:
    os.mkdir("/root/{}/".format(subdir))
except OSError:
    print "Directory already exists"
    sys.exit(1)

with open("/root/{}/e800_run.sh".format(subdir), "w") as script_file:
    script_file.write(script)
    script_file.write("\n")

with open("/root/{}/code.txt".format(subdir), "w") as code_file:
    code_file.write(code)
    code_file.write("\n")

with open("/root/eyeball/Dockerfile", "r") as template_file:
    template = template_file.read()
    dockerfile_content = pystache.render(template, {"subdir": subdir})
    with open("/root/{}/Dockerfile".format(subdir), "w") as dockerfile:
        dockerfile.write(dockerfile_content)

cli = docker.Client(base_url='unix://var/run/docker.sock')
response = [ast.literal_eval(line) for line in cli.build(
    path='/root/{}'.format(subdir), rm=True, tag='eyeballs/{}'.format(subdir)
)]

if not response[-1]["stream"].startswith("Successfully"):
    for line in response:
        print line
    sys.exit(1)

container = cli.create_container(image='eyeballs/{}'.format(subdir))

if container['Warnings'] is not None:
    print container['Warnings']
    sys.exit(1)

response = cli.start(container=container['Id'])

if response is not None:
    print response
    sys.exit(1)

retval = cli.wait(container=container, timeout=10)

if retval is not 0:
    print "Retval was", retval
    sys.exit(1)

output = cli.logs(container=container['Id'], stream=False)

cur = conn.cursor()
cur.execute("""
    UPDATE submissions
    SET
        output = %(output)s,
        pending = false
    WHERE id = %(id)s;
""", {'output': output, 'id': id})
cur.close()
conn.close()

cli.remove_container(container=container['Id'])
cli.remove_image(image='eyeballs/{}'.format(subdir))

shutil.rmtree("/root/{}".format(subdir))
