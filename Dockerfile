FROM ruby:2.5.3


RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt remove cmdtest
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

RUN apt-get update -qq && apt-get install -y yarn nodejs
RUN mkdir /artworkdraft
WORKDIR /artworkdraft
COPY Gemfile /artworkdraft/Gemfile
COPY Gemfile.lock /artworkdraft/Gemfile.lock
RUN bundle install
COPY . /artworkdraft

RUN yarn 
RUN bundle exec rails assets:precompile

ENV RAILS_ENV "production"
CMD rackup
