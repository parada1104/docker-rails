# use this repository for the base on the docker rails development and production rails app dockerize

### For development:
##### use the docker-compose.yml file

#####  in to the 'docker-rails' context
#### commands:
###### create new rails app
```bash
docker-compose run --no-deps web rails new . --force --database=postgresql
```

###### change permissions
```bash
sudo chown -R $USER:$USER .
```

###### after rails new finish its time to build app
```bash
docker-compose build web
```

###### it's time to up the postgresql and redis server
```bash
 docker-compose up -d db redis   #use -d flag for detach
```

###### ensure both, redis and db container are up
###### to log errors on container initialization use 
```bash
docker-compose up your-service #to see log on command do not use flag -d
```

###### now we need to do some changes on our rails application
###### in config/database.yml
###### add this lines under encoding
```ruby
host: db
username: postgres
password: password
```

###### to finish create config/initializers/sidekiq/rb with: 
###### all this because redis service is running on default 0.0.0.0 service host
```ruby
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379' }
end
```

###### add gems tu Gemfile
```ruby
foreman
sidekiq
redis
```

###### rebuild app with $ docker-compose build web

###### create database 
```bash
docker-compose run --rm web rails db:create db:migrate
```

###### finally brings upp your rails app
```bash
docker-compose up web
```