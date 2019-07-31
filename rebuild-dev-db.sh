#!/bin/bash

RAILS_ENV=development \
bundle exec rake \
  db:drop \
  db:create \
  db:migrate \
  db:fixtures:load \

RAILS_ENV=test \
bundle exec rake \
  db:migrate \
  db:fixtures:load

