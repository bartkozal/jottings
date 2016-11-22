# Jottings

[![CircleCI](https://circleci.com/gh/bkzl/jottings/tree/master.svg?style=svg&circle-token=ca1f409c3d363c3d4fd221151af529183329d8f6)](https://circleci.com/gh/bkzl/jottings/tree/master)

Development dependencies:

- Ruby
- PostgreSQL
- Redis
- MongoDB

Test dependencies:

- ChromeDriver

## Setup

1. Clone the repository
2. Run `bundle install`
3. Run `rails db:setup`
4. Run `rails t` to ensure that tests pass
5. Clone sharedb repository

## Development

1. Run `bundle exec foreman start -f Procfile.dev`

## Deployment

1. Run `git push dokku master`
