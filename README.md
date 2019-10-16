# MicroBlogger

## Local dev setup

Be sure to have ruby (2.6.n) installed. RVM is
recommended to manage ruby. This dev stack uses `guard` for
rapid style and test feedback. It is strongly recommended to
have it running for every dev change/session.

### Initial setup

* rvm install ruby-2.6.2 (or your ruby version manager of choice)
* bundle install
* rake db:create
* rake db:migrate
* rake db:fixtures:load

There is a shell script in the root that will rebuild both
the local dev and test databases which executes the last
three setup steps:
`./rebuild-dev-db.sh`

Currently fixture files are used to seed local and test dev
instead of the `rake db:seed` pattern.

### dev session

* `bundle exec guard`
* do work until tests pass.
* `quit` to exit guard

The guard config file is `/Guardfile`.

With (almost) every file save, associated tests to that file
are ran, if successful the whole suite is then executed.

After the test suite `rubocop` kicks off with
auto-correction flags.

Finally simple cover reports are updated.

## other notes
* minitest is the testing framework
* editorconfig: https://editorconfig.org/
* rails-erd: https://github.com/voormedia/rails-erd
