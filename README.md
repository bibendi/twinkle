# Twinkle

[![Code Climate](https://codeclimate.com/github/bibendi/twinkle/badges/gpa.svg)](https://codeclimate.com/github/bibendi/twinkle)
[![Test Coverage](https://codeclimate.com/github/bibendi/twinkle/badges/coverage.svg)](https://codeclimate.com/github/bibendi/twinkle/coverage)
[![Build Status](https://travis-ci.org/bibendi/twinkle.svg?branch=master)](https://travis-ci.org/bibendi/twinkle)
[![DockerHub Status](https://img.shields.io/docker/stars/zendesk/samson.svg)](https://hub.docker.com/r/bibendi/twinkle)
[![Dependency Status](https://gemnasium.com/bibendi/twinkle.svg)](https://gemnasium.com/bibendi/twinkle)

Notifications service.

Available transports: Telegram

## Usage

#### Send message

`curl -X POST --data "token=user-token&channel=sadness&message=Site+is+Down" http://twinkle.docker/messages`

Send message with JSON post-vars
`curl -X POST --data "token=user-token&channel=sadness&message=json-%{a.b}&json_vars=alert&alert='{"a": {"b": 1}}'" http://twinkle.docker/messages`

#### Show Resque statistics

http://twinkle.docker/resque_web

## Installation

### Transports

#### Telegram bot

The first step in creating our bot is to talk to the https://telegram.me/BotFather and get the token. Let’s create our bot using the command `/newbot`. Now we have to register for a username, note: it must end in bot, If our bot is named `TetrisBot` the username must be `tetrisbot`.

In order to get the group chat id, do as follows:
* Add the Telegram BOT to the group.
* Get the list of updates for your BOT: `https://api.telegram.org/bot<YourBOTToken>/getUpdates`

### DIP

#### Requirements

* Docker >= 1.12 https://www.docker.com/
* Docker Compose >= 1.9.0 https://github.com/docker/compose/releases
* DIP >= 2.0.0 https://github.com/bibendi/dip

#### Setup and Run

```sh
  dip dns up
  dip nginx up
  dip provision
  dip rails s
  dip rails c
  dip compose down

  RAILS_ENV=test dip rspec
  RAILS_ENV=test dip compose down
```

Check http://twinkle.docker/

## Roadmap

* Add transports: Email, SMS
