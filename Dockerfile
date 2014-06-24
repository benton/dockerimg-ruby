FROM ubuntu:latest
MAINTAINER Benton Roberts <benton@bentonroberts.com>

# set ruby version and location
ENV RUBY_V 1.9.3
ENV RUBY_P 547
ENV BASE_URL http://cache.ruby-lang.org/pub/ruby

# update ubuntu and install ruby requirements
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && \
  apt-get -y install curl build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev libffi-dev libgdbm-dev

# set system to utf-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# install ruby
RUN (curl -v ${BASE_URL}/ruby-${RUBY_V}-p${RUBY_P}.tar.gz | tar -xz) && \
  (cd ruby-* && ./configure --disable-install-doc && make && make install) && \
  rm -rf ruby-*

# update rubygems and install bundler
RUN gem update --system && gem install bundler --no-doc
