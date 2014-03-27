GHStreaks Service
==================

[![wercker status](https://app.wercker.com/status/f3c6aafdec3059c01d93f8abe9d7e81e/s/ "wercker status")](https://app.wercker.com/project/bykey/f3c6aafdec3059c01d93f8abe9d7e81e) [![Code Climate](https://codeclimate.com/github/suer/ghstreaks-service.png)](https://codeclimate.com/github/suer/ghstreaks-service/badges)

Preference
------------------

* environment variables
  - ZEROPUSH\_AUTH\_TOKEN

How to run
------------------

  $ bundle install --path .bundle
  $ bundle install rake db:migrate RAILS\_ENV=production
  $ bundle exec rails server

