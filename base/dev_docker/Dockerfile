#use your ruby version
FROM ruby:2.7.1-slim-buster

#install dependencies
RUN apt-get update -qq && apt-get install --no-install-recommends -y postgresql-client \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install --no-install-recommends -y nodejs yarn

#Set the directory on the container
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . .

EXPOSE 5000

# Start the main process.
CMD ["foreman", "start", "-f", "Procfile.dev"]