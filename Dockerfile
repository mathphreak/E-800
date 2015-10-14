FROM ruby:2.2.3
# RUN apt-get update -qq && apt-get install -y ???
RUN mkdir /e-800
WORKDIR /e-800
ADD Gemfile /e-800/Gemfile
ADD Gemfile.lock /e-800/Gemfile.lock
RUN bundle install
ADD . /e-800
