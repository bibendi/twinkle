#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
set -vx

bundle exec rake db:create db:migrate

exec bundle exec unicorn -c /app/config/unicorn.rb -E deployment
