# Hey with this guide and repository you should be able to build a Rails application on docker but also using redis, foreman, webpack dev server and also imagemagick(currently only avaiblable on ruby alpine dockerfile)
## use this repository for the base on the docker rails development and production rails app dockerize
## Base directory is for guidance on building your docker files
## Copy all the files in base directory to your future rails app directory
### For development:
#### commands:
###### create new rails app
```bash
docker-compose run --no-deps web rails new . --force --database=postgresql
```

###### change permissions
```bash
sudo chown -R $USER:$USER .
```

###### now we need to do some changes on our rails application
###### in config/database.yml
###### add this lines under encoding
```yaml
host: <%= ENV["DATABASE_HOST"] %>
username: <%= ENV["DATABASE_USERNAME"] %>
password: <%= ENV["DATABASE_PASSWORD] ">
```

###### add gems to Gemfile
```ruby
foreman
sidekiq
redis
```

###### rebuild app with
```bash
docker-compose build web
```

###### create database 
```bash
docker-compose run --rm web rails db:create db:migrate
```

###### finally brings up your rails app
```bash
docker-compose up --build web
```

### For Production:
### Commands:
###### we need to set production database.yml to our default conf or use a configuration of your preference
```ruby
production:
  <<: *default
database: myapp_production
```
###### we need to build de production image of our application 
```bash
docker-compose -f docker-compose.prod.yml build #you can also build both separate 
```
###### now its time to get all of our services up 
```bash
docker-compose -f docker-compose.prod.yml up -d  
```

###### time get up our services 
```bash
docker-compose -f docker-compose.prod.yml up -d --build #also you should skip -d flag to get logs of your container 
```

##### disclaimer: you can rename each file as your preferences