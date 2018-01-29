#!/bin/bash -e
# script is necessary to catch all signals as PID 1 in a container

set -x
pid=0

# SIGTERM-handler
term_handler() {
  echo "terminating ..."
  
  echo "terminating ssh ..."
  /etc/init.d/ssh stop
  
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; term_handler' SIGINT SIGKILL SIGTERM SIGQUIT SIGTSTP SIGSTOP SIGHUP

# run applications as services in the background now
echo "starting ssh ..."
/etc/init.d/ssh start &

#get process ID of most recently executed background
pid="$!"

# wait forever not to exit the container
while true
do
  tail -f /dev/null & wait ${!}
done

exit 0
