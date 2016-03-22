FROM ruby:2.3-slim

RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  make \
  gcc \
  g++ \
  libxml2-dev \
  libxslt-dev \
  pkg-config \
  libcurl3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Env
ENV RAILS_ENV development

EXPOSE 3000

# Install gems
COPY Gemfile Gemfile.lock /app/
WORKDIR /app
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install --jobs 4

# Setup application
RUN mkdir -p tmp/pids && \
  mkdir -p log && \
  ln -sf /dev/stdout /app/log/development.log
