# The Camdram Ruby Gem

Camdram-ruby is an API wrapper & interface for [Camdram](https://www.camdram.net) 🎭 that's made with love ❤️ and written in Ruby 💎.

## Quick Start
Any of the lines inside the config block can be omitted.
```ruby
require 'camdram/client'

client = Camdram::Client.new do |config|
  config.api_token = api_token
  config.user_agent = "MyApp v1.0.0"
  config.base_url = "https://www.camdram.net"
end
```

## Documentation
Full documentation is generated from the source code by [YARD](https://yardoc.org) and is available to view on
[RubyDocs](https://www.rubydoc.info/github/CHTJonas/camdram-ruby).

## Usage Examples
Just some of the things you can do after configuring a `client` object:
```ruby
client.user.get_shows
client.user.get_shows[0].society
client.user.get_shows[0].venue
client.user.get_shows[0].performances
client.user.get_orgs[0].name
client.user.get_orgs[0].twitter_id
```

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
spec.add_runtime_dependency 'camdram', '~> 1.0'
```

## Copyright
Copyright (c) 2006-2018 Charlie Jonas.
See [LICENSE](LICENSE) for details.
