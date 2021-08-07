#!/bin/sh
bundle exec rails assets:precompile --trace
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
foreman start