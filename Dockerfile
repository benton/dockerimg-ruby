FROM ubuntu:latest
MAINTAINER Benton Roberts <broberts@mdsol.com>

# Ruby version
ENV RUBY_V 2.1.2

# update ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && \
  apt-get -y install build-essential zlib1g-dev \
  libssl-dev libreadline6-dev libyaml-dev libffi-dev libgdbm-dev

# set system to utf-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# install ruby
ADD http://cache.ruby-lang.org/pub/ruby/ruby-${RUBY_V}.tar.gz /tmp/
RUN ls -al /tmp/
RUN tar -xzf /tmp/ruby-${RUBY_V}.tar.gz && \
    (cd ruby-${RUBY_V}/ && ./configure --disable-install-doc && make && make install) && \
    rm -rf ruby-${RUBY_V}/ /tmp/ruby-${RUBY_V}.tar.gz

# update rubygems and install bundler
RUN gem update --system && gem install bundler --no-doc
