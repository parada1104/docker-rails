use this repository for the base on the docker rails development and production rails app dockerize

For development:
use the docker-compose file

#in to the 'docker-rails' context
commands:
$ docker-compose run --no-deps rails new . --force --database=postgresql

after rails new finish its time to build app
$ docker-compose build web

#it's time to up the postgresql and redis server
$ docker-compose up -d db redis #use -d flag for detach

#ensure both, redis and db container are up
#to log errors on container initialization use $ docker-compose up your-service #to see log on command

#now we need to do some changes on our rails application
#in config/database.yml
add this lines under encoding
host: db
username: postgres
password: password

#to finish create config/initializers/sidekiq/rb with: #all this because redis service is running on default 0.0.0.0 service host
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:7372/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:7372/0' }
end

#add gems tu Gemfile
foreman
sidekiq
redis

#rebuild app with $ docker-compose build web

#create database 
$ docker-compose run --rm web rails db:create db:migrate

# finally brings upp your rails app
$ docker-compose up web
