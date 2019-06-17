# Video trimming

Api for video trimming.

[Api documentation](https://shrouded-eyrie-67421.herokuapp.com/apipie)

Api server https://shrouded-eyrie-67421.herokuapp.com

## Tech Stack

* ruby-2.6.3
* Rails 5
* Trailblazer 2.1
* MongoDB

## Setup Project

* Prerequisites: mongoDB, redis, ffmpeg
* Start sidekiq `bundle exec sidekiq -C config/sidekiq.yml`
* Start server `rails s`
