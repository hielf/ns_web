#!/bin/sh
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/ns_web
UNICORN=$rvm_path/bin/bootup_unicorn
CONFIG_FILE=$APP_ROOT/config/unicorn.rb
CMD="$APP_ROOT/bin/unicorn -D -c $APP_ROOT/config/unicorn.rb -E production"

action="$1"
set -u

case "$1" in
  start)
  $UNICORN -c $CONFIG_FILE -E production -D
  ;;
  stop)
  kill -QUIT `cat $APP_ROOT/tmp/unicorn.pid`
  ;;
  restart|force-reload)
    kill -USR2 `cat $APP_ROOT/tmp/unicorn.pid`
  ;;
  *)
   echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2
   exit 3
   ;;
esac