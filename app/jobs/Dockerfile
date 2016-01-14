FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init", "--quiet", "--", "sh", "-c", "sleep 1 && sh /root/e800_run.sh"]

# RUN apt-get update && apt-get install -y \

WORKDIR /root
COPY . .

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
