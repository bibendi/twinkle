# Twinkle

Notifications service.

Available transports: Telegram

## Usage

```
curl -X POST --data "token=twinkle-secret-token&channel=sadness&message=Site+is+Down" http://localhost:3000/messages
```

## Installation

### Development

```
$ cp .env.sample .env
$ vi .env
$ docker-compose build
$ docker-compose run --rm app bundle install

$ docker-compose up -d
$ docker-compose run --rm bundle exec rails c
$ docker-compose run --rm bundle exec rspec
```

### Production

TODO
