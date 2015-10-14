FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
  wget

# Install Docker within this container to spawn new containers dynamically
RUN wget -qO- https://get.docker.com/ | sh

# Install postgresql client for Python
RUN apt-get install -y python-psycopg2

# Add the scripts
ADD checkDB.py /root/checkDB.py
RUN chmod a+x /root/checkDB.py

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
