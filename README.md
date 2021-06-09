# Steep

## Contributors
* Hope McGee | [LinkedIn](linkedin.com/in/hope-mcgee)

## Description

Steep is Ruby on Rails API-only backend that allows a user (customer) to subscribe to different varieties of teas.

This may implement the [Tea API]().

## Versioning
* Ruby version: 2.5.3
* Rails version: 5.2.6

## Setup

Clone the app using the "Code" button above to download it to your machine. After you've done this, you can use ``` bundle install ``` and ``` rails db:setup ``` in your terminal/shell to set up the app locally.

## Testing

Testing is provided using RSpec. Test status can be checked by running ``` bundle exec rspec ``` in your terminal/shell once you've followed the setup above.

## Endpoints

```
POST '/api/v1/subscribe'
```
* This provides a way for a customer to subscribe to a variety of tea.
* This can also reactivate a subscription for a previously-unsubscribed tea.
* This requires "customer_id" and "tea_id" query params.

```
POST '/api/v1/unsubscribe'
```
* This provides a way for a customer to unsubscribe from a variety of tea.
* This requires "customer_id" and "tea_id" query params.
* This responds with "null" if there is no active subscription for that customer and tea data set.

```
GET '/api/v1/subscriptions'
```
* This provides a way to see all of a customer's subscriptions, active and inactive.
* This requires "customer_id" query param.
