⚠️ **WARNING**:
You are viewing the README on the `master` branch which contains as yet unreleased changes for version 2.0.0 of the gem.
You probably want to checkout a tag using the GitHub interface and view documentation for that version.

---

# The Camdram Ruby Gem

[![Gem Version](https://badge.fury.io/rb/camdram.svg)](https://badge.fury.io/rb/camdram)
[![Build Status](https://travis-ci.org/CHTJonas/camdram-ruby.svg?branch=master)](https://travis-ci.org/CHTJonas/camdram-ruby)

The Camdram gem is an API wrapper and interface for [Camdram](https://www.camdram.net) 🎭 that's made with love ❤️ and written in Ruby 💎.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'camdram', '~> 2.0'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install camdram
```

## Usage
Version 2 comes with significant backend changes which now allows you to use the [client credentials](http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.4) OAuth strategy in addition to [authorisation code](http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.1).

### Client Credentials
Use this strategy if you are writing a server-side application that accesses the Camdram API itself or on the behalf of the user who created it.

```ruby
require 'camdram/client'
client = Camdram::Client.new do |config|
  config.client_credentials(app_id, app_secret)
  config.user_agent = "MyApp v1.0.0"
  config.base_url = "https://www.camdram.net"
end
```

### Authorisation Code
Use this strategy if you are authenticating a user via Camdram login and then acting on that user's behalf with an access token you already have from eg. [omniauth-camdram](https://github.com/camdram/omniauth-camdram).
You will need a hash of the access token and optionally, if you want to refresh the token after it expires, the refresh token and [Unix time](https://en.wikipedia.org/wiki/Unix_time) when the access token expires.

```ruby
require 'camdram/client'
token_hash = {access_token: "mytoken", refresh_token: nil, expires_at: nil}
client = Camdram::Client.new do |config|
  config.auth_code(token_hash, app_id, app_secret)
  config.user_agent = "MyApp v1.0.0"
  config.base_url = "https://www.camdram.net"
end
```

### Read only
It's also possible to perform read-only requests to the Camdram API without API credentials, however this is *strongly* discouraged.

```ruby
require 'camdram/client'
client = Camdram::Client.new do |config|
  config.read_only
  config.user_agent = "MyApp v1.0.0"
  config.base_url = "https://www.camdram.net"
end
```

## Documentation
Full documentation is generated automatically from the source code by [YARD](https://yardoc.org) and is available to view on
[RubyDocs](https://www.rubydoc.info/gems/camdram).

## Examples
Just some of the things you can do after configuring a `client` object:
```ruby
client.user.get_shows
client.user.get_shows[0].society
client.user.get_shows[0].venue
client.user.get_shows[0].performances
client.user.get_societies
client.user.get_societies[0].name
client.user.get_societies[0].twitter_id
client.user.get_venues
client.user.get_venues[0].slug
client.user.get_venues[0].facebook_id
```

These public read-only actions don't require an access token (although you are still strongly advised to use one anyway):
```ruby
client.get_show(6171)
client.get_show("2018-lucky")

client.get_society(1)
client.get_society("cambridge-university-amateur-dramatic-club")

client.get_venue(29)
client.get_venue("adc-theatre")

client.get_person(13865)
client.get_person("charlie-jonas")

client.get_society("cambridge-footlights").shows
client.get_society("cambridge-footlights").news
client.get_venue("cambridge-arts-theatre").shows
client.get_venue("cambridge-arts-theatre").news
```

## Development
First download a copy of the source code:

```shell
git clone https://github.com/CHTJonas/camdram-ruby.git && cd camdram-ruby
```

Once you've made a few changes you can test that things are still working as expected:

```shell
APP_ID=yourappid APP_SECRET=yourappsecret rake test
```

## Contributing
Bug reports, enhancements and pull requests are welcome on [GitHub](https://github.com/CHTJonas/camdram-ruby)!
If you think this is something you can do yourself:
1. Fork it ( https://github.com/CHTJonas/camdram-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/).
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
that version should be immediately yanked and/or a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.
As a result of this policy, you can (and should) specify a dependency on this gem using the
[Pessimistic Version Constraint](http://guides.rubygems.org/patterns/#pessimistic-version-constraint) with two digits of precision.
For example:
```ruby
spec.add_runtime_dependency 'camdram', '~> 2.0'
```

## Copyright
Copyright (c) 2018-2019 Charlie Jonas.
See [LICENSE](LICENSE) for details.
