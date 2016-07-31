FROM ubuntu:16.04
MAINTAINER Hiroshi Shimoju <hiroshi.shimoju@gmail.com>

ENV PATH $PATH:/opt/puppetlabs/bin

# Add apt repositories
RUN apt-get update && apt-get install -y \
  curl \
  # Puppet
  && curl -fsSLO https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb \
  && dpkg -i puppetlabs-release-pc1-xenial.deb \
  && rm puppetlabs-release-pc1-xenial.deb

# Install packages
RUN apt-get update && apt-get install -y \
  puppet-agent \
  ruby \
  # Serverspec uses `netstat` command
  net-tools

ADD . /var/hondana
WORKDIR /var/hondana
RUN gem install bundler --no-document \
  && bundle install \
  && bundle exec librarian-puppet install
