# Jottings

[![CircleCI](https://circleci.com/gh/bkzl/jottings/tree/master.svg?style=svg&circle-token=ca1f409c3d363c3d4fd221151af529183329d8f6)](https://circleci.com/gh/bkzl/jottings/tree/master)

Development dependencies:

- Ruby: `2.3.x`
- PostgreSQL: `9.5.x`

Runtime (production) dependencies:

- Redis

## Setup

1. Clone the repository
2. Run `bundle install`
3. Run `rails db:setup`

## Development

1. Run `rails s`
2. Run `bundle exec guard`

## Deployment

1. Run `git push heroku master
