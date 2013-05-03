# ezra

[![Code Climate](https://codeclimate.com/github/del82/ezra.png)](https://codeclimate.com/github/del82/ezra)

ezra is a server-side tool for producing research-quality datasets of annotated audio files
from recordings available on the web.

The web contains vast quantities of recorded speech, and much of it is accompanied by
transcripts and is therefore discoverable by search engine queries. The web is thus a
potentially valuable source of data for speech research. But before audio files harvested
from the web can constitute research data, they must be subjected to processing. Each
search engine hit must be manually validated, and each token must be extracted with
the required amount of context and annotated with the appropriate metadata.

ezra is a simple but powerful web interface allowing non-expert users to perform this
processing efficiently. Its effectiveness as a corpus annotation tool has been demonstrated
in the production of corpora consisting of thousands of annotated tokens.


## Documentation

A basic [tutorial for annotators](https://github.com/del82/ezra/wiki/Tutorial-for-annotators)
is available, as is basic [developer documentation](https://github.com/del82/ezra/wiki).
Tutorials for supervisors will be available soon.

## Installation

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
    3. Or if you're feeling lazy: run this command from directory root. 
        `touch config/initializers/secret_token.rb; secret=$(rake secret); /`
        `echo "Ezra::Application.config.secret_token = '$secret'" >> config/initializers/secret_token.rb`
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
11. To start a server, run `ruby s`
12. Hack away

Notes:

- Installation on Ubuntu was aided by [this SO answer](http://stackoverflow.com/a/11274952), as .bashrc was adding .rvm/bin to $PATH before sourcing .rvm/scripts/rvm
- If you're running Linux, you may need to install a javascript runtime like
[Node.js](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager) if you haven't already.
