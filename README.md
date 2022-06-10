## README

## Tasks Performed

1. Write a simple API that will have 2 endpoints. First to list "queue jobs" and their statuses. The second endpoint should allow the creation of those jobs and adding them to the     queue. One of them should be a GET request and another should be a POST request. Queue jobs should be stored in a database. Queue jobs should have typical job system statuses like waiting, done, in progress, failed, etc. They should also have priority set like critical, high, low, etc.

2. Add support for working with queue jobs created above. They should be picked in order and based on set priority.
   Jobs that we would like to have done:
    a) Displaying/Returning current time and date.
    b) Storing movie titles in the database.

3. Add support for authentication to the API.

### Setup

* RVM or Rbenv - ruby version management
* Ruby 3.0.0p0
* Rails 7.0.3
* Bundler >= 1.15.0
* Postgresql

### Configuration

Installation of ruby and rails is done using RVM/Rbenv. Install the version manager of your choice and then run the following commands:
```
    rbenv install 3.0.0
```

#### Install the application

This should bundle install the gems listed in the Gemfile and create a database. The `brew bundle` command will install the dependencies listed at top.

Alternatively (to running `bin/setup`) you can run the following commands, these are the commands run as `bin/setup` from above:

    bundle install
    rails db:create
    rails db:migrate
