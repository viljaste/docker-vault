#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/vault/build.sh && /src/vault/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/vault/variables.sh && /src/vault/run.sh"
    ;;
esac
