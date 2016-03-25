# Twinkle

[![Code Climate](https://codeclimate.com/github/bibendi/twinkle/badges/gpa.svg)](https://codeclimate.com/github/bibendi/twinkle)
[![Test Coverage](https://codeclimate.com/github/bibendi/twinkle/badges/coverage.svg)](https://codeclimate.com/github/bibendi/twinkle/coverage)
[![DockerHub Status](https://img.shields.io/docker/stars/zendesk/samson.svg)](https://hub.docker.com/r/bibendi/twinkle)
[![Dependency Status](https://gemnasium.com/bibendi/twinkle.svg)](https://gemnasium.com/bibendi/twinkle)

Notifications service.

Available transports: Telegram

## Usage

#### Send message

`curl -X POST --data "token=user-token&channel=sadness&message=Site+is+Down" http://localhost:3000/messages`

#### Show Resque statistics

`http://localhost:3000/resque_web`

## Installation

### Transports

#### Telegram bot

The first step in creating our bot is to talk to the https://telegram.me/BotFather and get the token. Let’s create our bot using the command `/newbot`. Now we have to register for a username, note: it must end in bot, If our bot is named `TetrisBot` the username must be `tetrisbot`.

### Development

```
$ cp .env.sample .env
$ vi .env
$ docker-compose build
$ docker-compose run --rm app bundle install
$ docker-compose run --rm app bundle exec rake db:create
$ docker-compose run --rm app bundle exec rake db:migrate
$ docker-compose run --rm -e RAILS_ENV=test app bundle exec rake db:migrate
$ docker-compose up -d
```

### Production

#### Install

http://kontena.io/docs/getting-started/installing/

```
$ gem install kontena-cli
$ kontena login http://{kontena-master-endpoint}:8080
$ kontena grid create twinkle
```

#### Build

Build image and push to https://hub.docker.com/r/bibendi/twinkle

```
$ kontena app build
```

#### Deploy

```
$ kontena app deploy
```

### Add User, Channel and Transport

```
$ rails c
user = User.create!(name: "user_name")
channel = user.channels.create!(name: "channel_name")
bot = user.transports.create!(chat_id: -12345678)
channel.transports << bot
puts user.token
```

## Roadmap

* Add transports: Email, SMS
* Web interface
