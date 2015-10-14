FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
  wget

# Install Docker within this container to spawn new containers dynamically
RUN wget -qO- https://get.docker.com/ | sh

# Install postgresql client
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -
RUN apt-get update && apt-get install -y \
  postgresql-client-9.4

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
