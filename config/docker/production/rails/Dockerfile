FROM ruby:2.3-slim

RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  make \
  gcc \
  g++ \
  libxml2-dev \
  libxslt-dev \
  pkg-config \
  libcurl3-dev \
  libpq-dev \
  libgmp3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.9.0/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

ENV RAILS_ENV production

EXPOSE 3000

# Install gems
COPY Gemfile Gemfile.lock /app/
WORKDIR /app
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install --deployment --without development test --jobs 4

# Copy project files
COPY . /app

# Setup application
RUN mkdir -p tmp/pids && \
  rm -rf tmp/cache && \
  ln -sf /dev/stdout /app/log/unicorn.log && \
  ln -sf /dev/stdout /app/log/production.log && \
  ln -sf /dev/stdout /app/log/resque.log
