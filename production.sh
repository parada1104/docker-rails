#!/bin/sh
PREFIX="docker compose run --rm web"
$PREFIX bundle exec rails assets:precompile --trace

$PREFIX bin/rails db:create
$PREFIX bin/rails db:migrate
$PREFIX bin/rails db:seed
