FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# psycopg2 requires all sorts of dependencies so install it with apt

RUN apt-get update && apt-get install -y \
  python-pip \
  python-psycopg2

# Install docker API client for Python
RUN pip install docker-py

# Install mustache support in Python
RUN pip install pystache

# Add the scripts
COPY checkDB.py /root/checkDB.py
RUN chmod a+x /root/checkDB.py

# Add the mini stuff
COPY eyeball/ /root/eyeball/

# Run checkDB.py every ten seconds
RUN mkdir /etc/service/checkdb
COPY runDB.sh /etc/service/checkdb/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
