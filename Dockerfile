FROM ruby:2.2.3
# RUN apt-get update -qq && apt-get install -y ???
RUN mkdir /opt/e-800
WORKDIR /opt/e-800
COPY Gemfile /opt/e-800/Gemfile
COPY Gemfile.lock /opt/e-800/Gemfile.lock
RUN bundle install
COPY . /opt/e-800
