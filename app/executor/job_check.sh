#!/bin/sh
# running as nobody is important
exec /sbin/setuser nobody /usr/local/bin/run_code.sh
