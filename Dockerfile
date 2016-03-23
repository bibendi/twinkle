FROM ruby:2.3-slim

RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  make \
  gcc \
  g++ \
  libxml2-dev \
  libxslt-dev \
  pkg-config \
  libgmp3-dev \
  libcurl3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

EXPOSE 3000

ENV BUNDLE_PATH /app/vendor/bundle

RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
  gem install bundler && \
  bundle config --global jobs 4 && \
  bundle config --global without production && \
  bundle config --global build.nokogiri --use-system-libraries

WORKDIR /app
