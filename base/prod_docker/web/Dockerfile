FROM ruby:2.7.1-slim-buster
RUN apt-get update -qq && apt-get install --no-install-recommends -y postgresql-client \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install --no-install-recommends -y nodejs yarn

RUN mkdir -p /var/www/railsprod
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'

# Set working directory, where the commands will be ran:
WORKDIR /var/www/railsprod
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test
COPY . .
RUN bundle exec rails assets:precompile

# Add a script to be executed every time the container starts.
EXPOSE 5000

# Start the main process.
CMD ["foreman", "start", "-f", "Procfile"]