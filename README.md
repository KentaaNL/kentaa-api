# Kentaa API

[![Gem Version](https://badge.fury.io/rb/kentaa-api.svg)](https://badge.fury.io/rb/kentaa-api)
[![Build Status](https://travis-ci.org/KentaaNL/kentaa-api.svg?branch=master)](https://travis-ci.org/KentaaNL/kentaa-api)
[![Code Climate](https://codeclimate.com/github/KentaaNL/kentaa-api/badges/gpa.svg)](https://codeclimate.com/github/KentaaNL/kentaa-api)

This gem provides a Ruby library for communicating with the [Kentaa API](https://developer.kentaa.nl/kentaa-api/).

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Actions](#actions)
  - [Donation forms](#donation-forms)
  - [Donations](#donations)
  - [Manual donations](#manual-donations)
  - [Newsletter subscriptions](#newsletter-subscriptions)
  - [Projects](#projects)
  - [Segments](#segments)
  - [Sites](#sites)
  - [Teams](#teams)
  - [Users](#users)
  - [Pagination](#pagination)
- [Error handling](#error-handling)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

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

Create a Kentaa API configuration and client using your API key:

```ruby
require 'kentaa/api'

config = Kentaa::Api::Config.new('your_api_key')
client = Kentaa::Api::Client.new(config)
```

The configuration is created for the production environment by default. If you want to use the testing environment, then add `test: true`:

```ruby
config = Kentaa::Api::Config.new('your_api_key', test: true)
```

### Actions

```ruby
# List Actions
actions = client.actions.list  # paginated
actions = client.actions.all   # non-paginated

actions.each do |action|
  action.title  # => "Lorem ipsum"
  action.url  # => "https://demo1.kentaa.nl/actie/john-doe"
end

# Get Action by ID or slug
action = client.actions.get(1)
action = client.actions.get("john-doe")

action.title  # => "Lorem ipsum"
action.url  # => "https://demo1.kentaa.nl/actie/john-doe"

# Create a new Action
action = client.actions.create(
  title: "Lorem ipsum",
  description: "Dolorum animi qui nihil iure dolore velit.",
  owner_id: 1
)

action.id  # => 1
action.title  # => "Lorem ipsum"
action.description  # => "Dolorum animi qui nihil iure dolore velit."
action.owner  # => Kentaa::Api::Resources::User

# Update an Action
action = client.actions.update(1, title: "Foobar")

action.title  # => "Foobar"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#actions) and [Kentaa::Api::Resources::Action](lib/kentaa/api/resources/action.rb) for all available properties.

### Donation forms

```ruby
# List Donation forms
donation_forms = client.donation_forms.list  # paginated
donation_forms = client.donation_forms.all   # non-paginated

donation_forms.each do |form|
  form.title  # => "Lorem ipsum dolor sit amet"
  form.url  # => "https://demo1.kentaa.nl/form"
end

# Get Donation form
form = client.donation_forms.get(1)

form.title  # => "Lorem ipsum dolor sit amet"
form.owner  # => Kentaa::Api::Resources::User
form.url  # => "https://demo1.kentaa.nl/form"
form.total_amount  # => BigDecimal("95.0")
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#donation-forms) and [Kentaa::Api::Resources::DonationForm](lib/kentaa/api/resources/donation_form.rb) for all available properties.

### Donations

```ruby
# List Donations
donations = client.donations.list  # paginated
donations = client.donations.all   # non-paginated

donations.each do |donations|
  donation.first_name  # => "John"
  donation.last_name  # => "Doe"
end

# Get Donation
donation = client.donations.get(1)

donation.first_name  # => "John"
donation.last_name  # => "Doe"
donation.amount  # => BigDecimal("15.0")
donation.entity  # => Kentaa::Api::Resources::Site
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#donations) and [Kentaa::Api::Resources::Donation](lib/kentaa/api/resources/donation.rb) for all available properties.

### Manual donations

```ruby
# List Manual donations
donations = client.manual_donations.list  # paginated
donations = client.manual_donations.all   # non-paginated

donations.each do |donations|
  donation.first_name  # => "John"
  donation.last_name  # => "Doe"
end

# Get Manual donation
donation = client.manual_donations.get(1)

donation.first_name  # => "John"
donation.last_name  # => "Doe"
donation.amount  # => BigDecimal("15.0")
donation.entity  # => Kentaa::Api::Resources::Site

# Create a Manual donation
donation = client.manual_donations.create(
  first_name: "John",
  last_name: "Doe",
  amount: "15.0"
)

donation.id  # => 1
donation.first_name  # => "John"
donation.last_name  # => "Doe"
donation.amount  # => BigDecimal("15.0")
donation.entity  # => Kentaa::Api::Resources::Site

# Update a Manual donation
donation = client.manual_donations.update(1, first_name: "Jane")

donation.first_name  # => "Jane"

# Delete a Manual donation
client.manual_donations.delete(1)
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#manual-donations) and [Kentaa::Api::Resources::ManualDonation](lib/kentaa/api/resources/manual_donation.rb) for all available properties.

### Newsletter subscriptions

```ruby
# List Newsletter subscriptions
newsletter_subscriptions = client.newsletter_subscriptions.list  # paginated
newsletter_subscriptions = client.newsletter_subscriptions.all   # non-paginated

newsletter_subscriptions.each do |subscription|
  subscription.email  # => "john.doe@kentaa.nl"
  subscription.subscription_url  # => "https://demo1.kentaa.nl"
end

# Get Newsletter subscription
subscription = client.newsletter_subscriptions.get(1)

subscription.email  # => "john.doe@kentaa.nl"
subscription.subscription_url  # => "https://demo1.kentaa.nl"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#newsletter-subscriptions) and [Kentaa::Api::Resources::NewsletterSubscription](lib/kentaa/api/resources/newsletter_subscription.rb) for all available properties.

### Projects

```ruby
# List Projects
projects = client.projects.list  # paginated
projects = client.projects.all   # non-paginated

projects.each do |project|
  project.title  # => "Dignissimos provident rerum enim alias magni asperna..."
  project.target_amount  # => 250000
end

# Get Project by ID or slug
project = client.projects.get(1)
project = client.projects.get("project")

project.title  # => "Dignissimos provident rerum enim alias magni asperna..."
project.target_amount  # => 250000
project.url  # => "https://demo1.kentaa.nl/project/dignissimos-provident-rerum-enim-alias-magni-asperna"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#projects) and [Kentaa::Api::Resources::Project](lib/kentaa/api/resources/project.rb) for all available properties.

### Recurring donors

```ruby
# List Recurring donors
recurring_donors = client.recurring_donors.list  # paginated
recurring_donors = client.recurring_donors.all   # non-paginated

recurring_donors.each do |recurring_donor|
  recurring_donor.first_name  # => "John"
  recurring_donor.last_name  # => "Doe"
end

# Get Recurring donor
recurring_donor = client.recurring_donors.get(1)

recurring_donor.first_name  # => "John"
recurring_donor.last_name  # => "Doe"
recurring_donor.amount  # => BigDecimal("15.0")
recurring_donor.entity  # => Kentaa::Api::Resources::DonationForm
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#recurring-donors) and [Kentaa::Api::Resources::RecurringDonor](lib/kentaa/api/resources/recurring_donor.rb) for all available properties.

### Segments

```ruby
# List Segments
segments = client.segments.list  # paginated
segments = client.segments.all   # non-paginated

segments.each do |segment|
  segment.name  # => "Segment 2"
  segment.url  # => "https://segment-2.demo1.kentaa.nl/"
end

# Get Segment
segment = client.segments.get(1)

segment.name  # => "Segment 2"
segment.title  # => "Aut est maxime nostrum."
segment.url  # => "https://segment-2.demo1.kentaa.nl/"
segment.target_amount  # => 2685
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#segments) and [Kentaa::Api::Resources::Segment](lib/kentaa/api/resources/segment.rb) for all available properties.

### Sites

The only method here is `current`, since there is only one site per API key.

```ruby
# Get current Site
site = client.sites.current

site.title  # => "Aut est maxime nostrum."
site.description  # => "Maiores ut velit fugiat eos. Quae est nostrum rerum aut et nihil. Sequi eveniet occaecati et est corporis et enim."
site.url  # => "https://demo1.kentaa.nl/"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#sites) and [Kentaa::Api::Resources::Site](lib/kentaa/api/resources/site.rb) for all available properties.

### Teams

```ruby
# List Teams
teams = client.teams.list  # paginated
teams = client.teams.all   # non-paginated

teams.each do |team|
  team.name  # => "Asperiores beatae voluptate qui."
  team.url  # => "https://demo1.kentaa.nl/team/asperiores-beatae-voluptate-qui"
end

# Get Team by ID or slug
team = client.teams.get(1)
team = client.teams.get("team")

team.name  # => "Asperiores beatae voluptate qui."
team.url  # => "https://demo1.kentaa.nl/team/asperiores-beatae-voluptate-qui"
team.total_amount  # => BigDecimal("225.0")
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#teams) and [Kentaa::Api::Resources::Team](lib/kentaa/api/resources/team.rb) for all available properties.

### Users

```ruby
# List Users
users = client.users.list  # paginated
users = client.users.all   # non-paginated

users.each do |user|
  user.first_name  # => "John"
  user.last_name  # => "Doe"
end

# Get User
user = client.users.get(1)

user.first_name  # => "John"
user.last_name  # => "Doe"

# Create an User
user = client.users.create(
  first_name: "John",
  last_name: "Doe"
)

user.id  # => 1
user.first_name  # => "John"
user.last_name  # => "Doe"

# Update an User
user = client.users.update(1, first_name: "Jane")

user.first_name  # => "Jane"

# Authenticate an User
user = client.users.auth(email: "john.doe@kenta.nl", password: "secret")

user.id  # => 1
user.first_name  # => "John"
user.last_name  # => "Doe"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#users) and [Kentaa::Api::Resources::User](lib/kentaa/api/resources/user.rb) for all available properties.

### Pagination

The `list` method on the endpoint returns an [Enumerable](https://ruby-doc.org/core/Enumerable.html) object with paginated results.
Default page size is 25, but you can can customize this by setting the `per_page` parameter:

```ruby
actions = client.actions.list(per_page: 100)

actions.each do |action|
  action.title  # => "Lorem ipsum"
  action.url  # => "https://demo1.kentaa.nl/actie/john-doe"
end
```

You can iterate through the pages using the `.next` method and checking the result:

```ruby
actions = client.actions.list

loop do  
  actions.each do |action|
    # Do something with actions
  end

  actions = actions.next
  break if actions.nil?
end
```

The `all` method on the endpoint returns a lazy [Enumerator](https://ruby-doc.org/core/Enumerator.html) and will automatically iterate through all pages and retrieve the requested data.

```ruby
actions = client.actions.all

actions.each do |action|
  action.title  # => "Lorem ipsum"
  action.url  # => "https://demo1.kentaa.nl/actie/john-doe"
end
```

See [Kentaa::Api::Resources::List](lib/kentaa/api/resources/list.rb) for all available pagination methods.

## Error handling

All responses that are not HTTP status 20x will result in a [Kentaa::Api::RequestError](lib/kentaa/api/exception.rb).

```ruby
begin
  client.actions.get("invalid")
rescue Kentaa::Api::RequestError => e
  e.message  # => "404: Requested resource was not found."
  e.http_code  # => 404
  e.errors  # => Array[Kentaa::Api::Resources::Error]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/KentaaNL/kentaa-api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

