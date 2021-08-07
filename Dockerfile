FROM ruby:3.0.0-alpine as dev-build

RUN apk add --update --virtual \
    runtime-deps \
    postgresql-client \
    build-base \
    libxml2-dev \
    libxslt-dev  \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    build-base \
    postgresql-dev \
    libc-dev \
    linux-headers \
    readline-dev \
    file \
    imagemagick \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/
COPY /Gemfile /Gemfile
COPY /Gemfile.lock /Gemfile.lock

RUN gem install foreman
ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

CMD ["foreman", "start", "-f", "Procfile.dev"]
EXPOSE 5000

FROM ruby:3.0.0-alpine as prod-build
RUN apk add --update --virtual \
    runtime-deps \
    postgresql-client \
    build-base \
    libxml2-dev \
    libxslt-dev  \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    postgresql-dev \
    libc-dev \
    linux-headers \
    readline-dev \
    file \
    imagemagick \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

ENV RAILS_ENV='production'
ENV RAKE_ENV='production'

# Set working directory, where the commands will be ran:
WORKDIR /app
COPY . /app
RUN yarn install
RUN bundle install --jobs 20 --retry 5 --without development test
RUN bundle exec rails assets:precompile

EXPOSE 5000

CMD ["foreman", "start", "-f", "Procfile"]