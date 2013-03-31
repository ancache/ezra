Ezra on rails.

Set up:

1. Install [RVM](https://rvm.io/) (may need to run with the `--ruby` flag)
2. Install ruby 1.9.3: `$ rvm install 1.9.3`
3. restart the shell
4. `$ git clone git@github.com:del82/ezra.git`
5. `$ bundle install` (may need to say `gem install bundler` first)
6. Generate a site-specific secret token.
    1. Copy `config/initializers/secret_token_template.rb` to
       `config/initializers/secret_token.rb`
    2. In `secret_token.rb` replace `'your secret token'` with an actual
       secret token, which can be generated by saying `rake secret` at the
       shell prompt
7. initialize the db:
  -  (if pulling) `$ rake db:reset`
  -  `$ rake db:migrate`
  -  `$ rake db:populate`
  -  `$ rake db:test:prepare`
8. annotate the source: `bundle exec annotate`
9. run the tests:
  -  `$ rspec`
10. If you like, start guard/spork to detect code changes and run tests
  automatically.
  - `$ guard`
11. Hack away

Notes:

- Installation on Ubuntu was aided by [this SO answer](http://stackoverflow.com/a/11274952), as .bashrc was adding .rvm/bin to $PATH before sourcing .rvm/scripts/rvm
- If you're running Linux, you may need to install a javascript runtime like
[Node.js](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager) if you haven't already.
