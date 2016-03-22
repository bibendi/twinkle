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
$ docker-compose up
```

### Production

TODO
