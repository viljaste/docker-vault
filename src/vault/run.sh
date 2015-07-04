#!/usr/bin/env bash

puppet apply --modulepath=/src/vault/run/modules /src/vault/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf
