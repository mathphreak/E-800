FROM ruby:2.2.3
# RUN apt-get update -qq && apt-get install -y ???
RUN mkdir /e-800
WORKDIR /e-800
COPY Gemfile /e-800/Gemfile
COPY Gemfile.lock /e-800/Gemfile.lock
RUN bundle install
COPY . /e-800
