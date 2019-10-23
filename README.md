# Jungle

A mini e-commerce application built with Rails 4.2 and tested with RSpec and Capybara.

### Author

Berker Erol. October 2019.

## Interface

### Landing Page

Landing page, with an overview of all available products.

!["landing page"](docs/landing_page.png)

### Cart

Displays the content of the cart to proceed with order.

!["checkout page"](docs/checkout_page.png)

### Checkout Page

Secure checkout provided by Stripe API.

!["checkout page"](docs/checkout.png)

### Implemented Tests

Unit and integration tests using RSpec and Capybara.

!["unit tests"](docs/test.png)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
