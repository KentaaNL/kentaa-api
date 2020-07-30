# Kentaa API

[![Gem Version](https://badge.fury.io/rb/kentaa-api.svg)](https://badge.fury.io/rb/kentaa-api)
[![Build Status](https://travis-ci.org/KentaaNL/kentaa-api.svg?branch=master)](https://travis-ci.org/KentaaNL/kentaa-api)
[![Code Climate](https://codeclimate.com/github/KentaaNL/kentaa-api/badges/gpa.svg)](https://codeclimate.com/github/KentaaNL/kentaa-api)

This gem provides a Ruby library for communicating with the [Kentaa API](https://api.kentaa.nl/v1/doc).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kentaa-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kentaa-api

## Usage

### Initialization

Create the client with your API key:

```ruby
require 'kentaa/api'

config = Kentaa::Api::Config.new('your_api_key')
client = Kentaa::Api::Client.new(config)
```

### Retrieving data

All endpoints use the same convention for retrieving data. The method `list` is for retrieving multiple resources. The method `get` is used for retrieving a single resource.

The `list` method on the endpoint returns an [Enumerable](https://ruby-doc.org/core/Enumerable.html) object:

```ruby
actions = client.actions.list

actions.each { |a| puts a.title }
actions.first
```

The results might be part of a paginated set. You can query the next page by doing:

```ruby
actions = actions.next if actions.next_page?
```

See also `Kentaa::Api::Resources::List` for the available methods for pagination.

The `all` method on the endpoint returns an [Enumerator](https://ruby-doc.org/core/Enumerator.html) and will iterate automatically through all pages to retrieve the requested data.

```ruby
actions = client.actions.all

actions.each { |a| puts a.title }
actions.first(100)
```

### Requests

Below a summary of the supported requests per endpoint.

#### Actions

```ruby
actions = client.actions.list             # get actions (paginated)
actions = client.actions.all              # get all actions (non-paginated)

action = client.actions.get(1)            # query action by ID
action = client.actions.get("john-doe")   # query action by slug
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/actions).

#### Donations

```ruby
donations = client.donations.list      # get donations (paginated)
donations = client.donations.all       # get all donations (non-paginated)

donation = client.donations.get(1)     # query donation by ID
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/donations).

#### Newsletter subscriptions

```ruby
newsletter_subscriptions = client.newsletter_subscriptions.list       # get newsletter subscriptions (paginated)
newsletter_subscriptions = client.newsletter_subscriptions.all        # get all newsletter subscriptions (non-paginated)


newsletter_subscriptions = client.newsletter_subscriptions.get(1)     # query newsletter subscription by ID
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/newsletter-subscriptions).

#### Projects

```ruby
projects = client.projects.list            # get projects (paginated)
projects = client.projects.all             # get all projects (non-paginated)

project = client.projects.get(1)           # query project by ID
project = client.projects.get("project")   # query project by slug
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/projects).

#### Segments

```ruby
segments = client.segments.list       # get segments (paginated)
segments = client.segments.all        # get all segments (non-paginated)

segment = client.segments.get(1)      # query segment by ID
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/segments).

#### Sites

The only method here is `current`, since there is only one site.

```ruby
site = client.sites.current    # get the current site
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/sites).

#### Teams

```ruby
teams = client.teams.list          # get teams (paginated)
teams = client.teams.all           # get all teams (non-paginated)

team = client.teams.get(1)         # query team by ID
team = client.teams.get("team")    # query team by slug
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/teams).


#### Users

```ruby
users = client.users.list          # get users (paginated)
users = client.users.all           # get all users (non-paginated)

user = client.users.get(1)         # query user by ID
```

See also the [Kentaa API docs](https://api.kentaa.nl/v1/doc/users).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KentaaNL/kentaa-api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

