# About My Marketplace API 🧑‍💻

My Marketplace API is a simple e-commerce web API that includes basic payment, CRUD (create, read, update, delete) functionality for orders, products, and users. This project is developed using Ruby on Rails with a focus on test-driven development and best practices, and will include new features in the future.

Note: The documentation for this API will be attached in Postman later 🗿. (On Progress)

## Tech Stack ⚙️

- Ruby on Rails 7.0.x (Ruby 3.0.x)
- PostgreSQL

## Gem Used 💎

- [RSpec](https://github.com/rspec/rspec-metagem), [RSpec-Rails](https://github.com/rspec/rspec-rails) (for testing the code )
- [JWT](https://github.com/jwt/ruby-jwt) (for authentication)
- [Rubocop](https://github.com/rubocop/rubocop), [Rubocop-Rails](https://github.com/rubocop/rubocop-rails) (this gem focused on enforcing Rails best practices and coding conventions.)
- [Rack-Cors](https://github.com/cyu/rack-cors) (to provides support for Cross-Origin Resource Sharing (CORS) for Rack compatible web applications.)
- [Kaminari](https://github.com/kaminari/kaminari) (for pagination)

## How to install❓
- Download Ruby 3.0.0 v
- Install Rails `gem install rails`
- Clone this repo (main)
- Run this command in your console/terminal
  1. `bundle install`
  2. `sudo service postgresql start` for connect to the database
  3. `rails db:create db:migrate`
- To run this app you can run this `rails server` or `rails s` command in the terminal
- To test the unit and integration test you can run this `rspec .` or you can check rspec documentation for more details.
