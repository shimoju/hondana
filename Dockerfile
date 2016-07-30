FROM ubuntu:16.04
MAINTAINER Hiroshi Shimoju <hiroshi.shimoju@gmail.com>

RUN apt-get update && apt-get install -y \
  ruby \
  # Serverspec uses `netstat` command
  net-tools

ADD . /var/hondana
WORKDIR /var/hondana
RUN gem install bundler --no-document && bundle install
