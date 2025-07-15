# Kentaa API

[![Gem Version](https://badge.fury.io/rb/kentaa-api.svg)](https://badge.fury.io/rb/kentaa-api)
[![Build Status](https://github.com/KentaaNL/kentaa-api/actions/workflows/test.yml/badge.svg)](https://github.com/KentaaNL/kentaa-api/actions)
[![Code Climate](https://codeclimate.com/github/KentaaNL/kentaa-api/badges/gpa.svg)](https://codeclimate.com/github/KentaaNL/kentaa-api)

This gem provides a Ruby library for communicating with the [Kentaa API](https://developer.kentaa.nl/kentaa-api/).

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
  - [Actions](#actions)
  - [Activities](#activities)
  - [Companies](#companies)
  - [Donation forms](#donation-forms)
  - [Donations](#donations)
  - [Manual donations](#manual-donations)
  - [News](#news)
  - [Newsletter subscriptions](#newsletter-subscriptions)
  - [Orders](#orders)
  - [Payments](#payments)
  - [Performances](#performances)
    - [Photos](#performance-photos)
  - [Projects](#projects)
  - [Recurring donors](#recurring-donors)
  - [Segments](#segments)
  - [Sites](#sites)
  - [Teams](#teams)
  - [Users](#users)
    - [Avatar](#user-avatar)
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

Create a Kentaa API client using your API key:

```ruby
require 'kentaa/api'

client = Kentaa::Api::Client.new(api_key: 'your_api_key')
```

The client is created for the production environment by default. If you want to use the testing environment, then add `test: true`:

```ruby
client = Kentaa::Api::Client.new(api_key: 'your_api_key', test: true)
```

### Actions

```ruby
# List Actions
actions = client.actions       # paginated
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


### Activities

```ruby
# List Activities
activities = client.activities

activities.each do |activity|
  activity.name  # => "Walking"
end

# Get Activity by ID
activity = client.activities.get(1)

activity.name  # => "Walking"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#activities) and [Kentaa::Api::Resources::Activity](lib/kentaa/api/resources/activity.rb) for all available properties.


### Companies

```ruby
# List Companies
companies = client.companies       # paginated
companies = client.companies.all   # non-paginated

companies.each do |company|
  company.title  # => "Lorem ipsum"
  company.url  # => "https://demo1.kentaa.nl/bedrijven/kentaa-bv"
end

# Get Company by ID or slug
company = client.companies.get(1)
company = client.companies.get("kentaa-bv")

company.title  # => "Lorem ipsum"
company.url  # => "https://demo1.kentaa.nl/bedrijven/kentaa-bv"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#companies) and [Kentaa::Api::Resources::Company](lib/kentaa/api/resources/company.rb) for all available properties.

### Donation forms

```ruby
# List Donation forms
donation_forms = client.donation_forms       # paginated
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
donations = client.donations       # paginated
donations = client.donations.all   # non-paginated

donations.each do |donation|
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
donations = client.manual_donations       # paginated
donations = client.manual_donations.all   # non-paginated

donations.each do |donation|
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

### News

```ruby
# List News
news = client.news       # paginated
news = client.news.all   # non-paginated

news.each do |news_item|
  news_item.title   # => "Lorem ipsum"
  news_item.content  # => "<p>"Dolorum animi qui nihil iure dolore velit."</p>"
end

# Get News
news_item = client.news.get(1)

news_item.title    # => "Lorem ipsum"
news_item.content  # => "<p>"Dolorum animi qui nihil iure dolore velit."</p>"
```
See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#news) and [Kentaa::Api::Resources::News](lib/kentaa/api/resources/news.rb) for all available properties.

### Newsletter subscriptions

```ruby
# List Newsletter subscriptions
newsletter_subscriptions = client.newsletter_subscriptions       # paginated
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

### Orders

```ruby
# List Orders
orders = client.orders       # paginated
orders = client.orders.all   # non-paginated

orders.each do |order|
  order.first_name  # => "John"
  order.last_name  # => "Doe"
end

# Get Order
order = client.orders.get(1)

order.name  # => "John Doe"
order.total_amount # => BigDecimal("15.0")
order.site  # => Kentaa::Api::Resources::Site
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#orders) and [Kentaa::Api::Resources::Order](lib/kentaa/api/resources/order.rb) for all available properties.

### Payments

```ruby
# Get Payment
payment = client.payments.get(1)

payment.total_amount  # => BigDecimal("95.0")
payment.donations  # => Array[Kentaa::Api::Resources::Donation]
payment.orders  # => Array[Kentaa::Api::Resources::Order]
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#payments) and [Kentaa::Api::Resources::Payment](lib/kentaa/api/resources/payment.rb) for all available properties.

### Performances

Performances are available on an [Kentaa::Api::Resources::Action](lib/kentaa/api/resources/action.rb), so you first need to retrieve an Action.

```ruby
action = client.actions.get(1)

# List Performances
performances = action.performances       # paginated
performances = action.performances.all   # non-paginated

performances.each do |performance|
  performance.title  # => "First tour"
  performance.distance  # => BigDecimal("65.25")
end

# Get Performance
donation = action.performances.get(1)

performance.title  # => "First tour"
performance.distance  # => BigDecimal("65.25")

# Create a Performance
performance = action.performances.create(
  title: "First tour",
  performance_type: "biking",
  performance_at: Time.now,
  distance: "65.25"
)

performance.title  # => "First tour"
performance.distance  # => BigDecimal("65.25")

# Update a Performance
performance = action.performances.update(1, title: "Big tour")

performance.title  # => "Big tour"

# Delete a Performance
action.performances.delete(1)
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#performances) and [Kentaa::Api::Resources::Performance](lib/kentaa/api/resources/performance.rb) for all available properties.

#### Performance photos

```ruby
# List Performance photos
photos = performance.photos       # paginated
photos = performance.photos.all   # non-paginated

photos.each do |photo|
  photos.image_url  # => "https://cdn.kentaa.nl/action_performance_photos/file/1/normal_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg"
end

# Get Performance photo
photo = performance.photos.get(1)

photo.image_url  # => "https://cdn.kentaa.nl/action_performance_photos/file/1/normal_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg"

# Create a Performance photo
photo = performance.photos.create(
  io: File.open("photo.jpeg"),
  content_type: "image/jpeg"
)

photo.image_url  # => "https://cdn.kentaa.nl/action_performance_photos/file/1/normal_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#performances-photos) and [Kentaa::Api::Resources::PerformancePhoto](lib/kentaa/api/resources/performance_photo.rb) for all available properties.

### Projects

```ruby
# List Projects
projects = client.projects       # paginated
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
project.url  # => "https://demo1.kentaa.nl/project/dignissimos-provident"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#projects) and [Kentaa::Api::Resources::Project](lib/kentaa/api/resources/project.rb) for all available properties.

### Recurring donors

```ruby
# List Recurring donors
recurring_donors = client.recurring_donors       # paginated
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
segments = client.segments       # paginated
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
teams = client.teams       # paginated
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
users = client.users       # paginated
users = client.users.all   # non-paginated

users.each do |user|
  user.first_name  # => "John"
  user.last_name  # => "Doe"
end

# Get User
user = client.users.get(1)

user.first_name  # => "John"
user.last_name  # => "Doe"

# Create a User
user = client.users.create(
  first_name: "John",
  last_name: "Doe"
)

user.id  # => 1
user.first_name  # => "John"
user.last_name  # => "Doe"

# Update a User
user = client.users.update(1, first_name: "Jane")

user.first_name  # => "Jane"

# Authenticate a User
user = client.users.auth(email: "john.doe@kentaa.nl", password: "secret")

user.id  # => 1
user.first_name  # => "John"
user.last_name  # => "Doe"
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#users) and [Kentaa::Api::Resources::User](lib/kentaa/api/resources/user.rb) for all available properties.

#### User avatar

```ruby
# Get the User avatar
avatar = user.avatar

avatar.avatar_url  # => "https://cdn.kentaa.nl/avatars/avatar/1/thumb_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg"

# Create / update the User avatar
avatar = user.avatar.create(
  io: File.open("photo.jpeg"),
  content_type: "image/jpeg"
)

avatar.avatar_url  # => "https://cdn.kentaa.nl/avatars/avatar/1/thumb_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg"

# Delete the User avatar
user.avatar.delete
```

See also the [Kentaa API docs](https://developer.kentaa.nl/kentaa-api/#user-avatars) and [Kentaa::Api::Resources::Avatar](lib/kentaa/api/resources/avatar.rb) for all available properties.

### Pagination

All List actions return paginated results in an [Enumerable](https://ruby-doc.org/core/Enumerable.html) object. The default page size is 25, but you can can customize this by setting the `per_page` parameter.

```ruby
actions = client.actions(per_page: 100)

actions.each do |action|
  action.title  # => "Lorem ipsum"
  action.url  # => "https://demo1.kentaa.nl/actie/john-doe"
end
```

You can iterate through the pages using the `.next` method and checking the result. For example:

```ruby
actions = client.actions

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
