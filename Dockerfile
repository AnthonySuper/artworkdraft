FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /artworkdraft
WORKDIR /artworkdraft
COPY Gemfile /artworkdraft/Gemfile
COPY Gemfile.lock /artworkdraft/Gemfile.lock
RUN bundle install --without development test
COPY . /artworkdraft
