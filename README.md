# Jottings

[![CircleCI](https://circleci.com/gh/bkzl/jottings-mvp.svg?style=svg&circle-token=ca1f409c3d363c3d4fd221151af529183329d8f6)](https://circleci.com/gh/bkzl/jottings-mvp)

Dependencies:

- Ruby
- Node
- PostgreSQL
- Redis
- MongoDB
- ChromeDriver

## Setup

1. Clone jottings-sharedb first
2. Clone this repository
3. Run `bundle install`
4. Run `rails db:setup`
5. Run `rails t` to ensure that tests pass

## Development

1. Run `bundle exec foreman start -f Procfile.dev`

## Deployment

1. Run `git push dokku master`
