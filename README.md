## README

## Tasks Performed

1. APIs for
    * Get list of enqueued jobs
    * Enqueue a new job
    * User sign-in API
    * User sign-up API


2. Add support for working with queue jobs created above. They should be picked in order and based on set priority.
   Jobs that we would like to have done:
    a) Displaying/Returning current time and date.
    b) Storing movie titles in the database.

3. Add support for authentication to the API.

### Setup
* RVM or Rbenv - ruby version management
* Ruby 3.1.2
* Rails 7.0.3
* Bundler >= 1.15.0
* Postgresql

### Configuration

Installation of ruby and rails is done using RVM/Rbenv. Install the version manager of your choice and then run the following commands:

```
    rbenv install 3.1.2
```

#### Install the application

This should bundle install the gems listed in the Gemfile and create a database. The `brew bundle` command will install the dependencies listed at top.

Alternatively (to running `bin/setup`) you can run the following commands, these are the commands run as `bin/setup` from above:

    bundle install
    rails db:setup
    whenever --update-crontab

### Postman collection

Checkout below postman documentation for APIs [here](https://documenter.getpostman.com/view/14666383/Uz5MGEj7)
### Demo
You can check the demo video [here](https://drive.google.com/file/d/1OfAD4_SkRsqc5ZEQHP2g0rbP9F8wmn5M/view)
