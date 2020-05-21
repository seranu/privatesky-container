#!/bin/sh
set -e
this_script=$(basename -- "$0")


for a in "$@"; do
  case $a in
    run-host)
      exec docker run --network host -it privatesky bash
      ;;
    run)
      exec docker run -p 8080:8080 -p 5000:5000 -p 5001:5001 -it privatesky bash
      ;;
    clean-build)
      exec docker build --no-cache -t privatesky:latest .
      ;;
    build)
      exec docker build -t privatesky:latest .
      ;;
    help)
      echo "Usage: ${this_script} COMMAND [OPTIONS]"
      echo "     COMMANDS: build, clean-build, run, help"
      ;;
    *)
      echo "Invalid command \"$1\". Run \"${this_script} help\" for usage details"
      ;;
  esac
done


# docker build -t privatesky:latest .
# TODO: expose only required ports
#docker run --network host -it privatesky bash
