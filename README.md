# Jottings [![Build Status](https://semaphoreci.com/api/v1/bkzl/jottings/branches/master/shields_badge.svg)](https://semaphoreci.com/bkzl/jottings)

![intro](https://github.com/bkzl/jottings/raw/master/app/assets/images/img-readme.gif)

Dependencies:

* Ruby
* Node
* PostgreSQL
* Redis
* MongoDB

## Setup

1.  Set up [jottings-sharedb](https://github.com/bkzl/jottings-sharedb)
2.  Run `bundle install`
3.  Run `rails db:setup`
4.  Run `rails t`

## Development

1.  Run `bundle exec foreman start -f Procfile.dev`

## Deployment

1.  Run `git push dokku master`
