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
$ docker-compose run --rm app bundle exec rake db:create
$ docker-compose run --rm app bundle exec rake db:migrate
$ docker-compose up -d
```

### Production

TODO
