#use your ruby version
FROM ruby:3.0.0-alpine

#install dependencies
RUN apk --update add build-base nodejs tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev imagemagick yarn
#Set the directory on the container
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . .

EXPOSE 5000

# Start the main process.
CMD ["foreman", "start", "-f", "Procfile.dev"]