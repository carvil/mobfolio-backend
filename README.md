# Mobfolio API

## Setup

Make sure your system has the following software:

    Ruby 2+
    PostgreSQL

Install the dependencies:

    $ bundle install

And create an initial user:

    $ bundle exec rails c
    > User.create!(email: 'johndoe@gmail.com', password: 'password')

Take note of the `authentication_token` provided.

Then start the rails server:

    $ bundle exec rails s

And try it out:

    $ curl -i -H 'Authorization: Token token=<YOUR_TOKEN>' http://localhost:3000

You should see a `200 OK` status in the response.
