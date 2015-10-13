# Use arch linux
FROM base/archlinux

# Update nonsense
FROM base/archlinux
RUN pacman-key --populate
RUN pacman-key --refresh-keys
RUN pacman -Sqyu --noconfirm
RUN pacman-db-upgrade

# Install the tools that let us use chroots
RUN pacman -qS --noconfirm arch-install-scripts

# Install the postgresql libraries
RUN pacman -qS --noconfirm postgresql

# Bootstrap chroots
# RUN mkdir -p /srv/chroot/code
# RUN debootstrap --include=g++ jessie /srv/chroot/code

# Copy in schroot configuration
# ADD schroot.conf /etc/schroot/schroot.conf

# Bring in the service to check for jobs
# RUN mkdir /etc/service/job_check
# ADD job_check.sh /etc/service/job_check/run

# Copy over the compilation script
# ADD run_code.sh /usr/local/bin/run_code.sh
# RUN chmod a+rx /usr/local/bin/run_code.sh

# Prepare good permissions for volume
# RUN mkdir /var/code && chmod 777 /var/code

# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run the system
CMD ["/usr/sbin/init"]
