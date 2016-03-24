#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
set -vx

bundle exec rake db:create

bundle exec rake db:migrate

bundle exec rake assets:precompile

exec bundle exec unicorn -c /app/config/unicorn.rb -E deployment
