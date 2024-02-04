# README
Welcome to teslazonda's Loyalty Tiers [API](https://github.com/teslazonda/ichigo-loyalty-tiers) documentation. This Rails API is one of two parts of teslazonda's solution to the Ichigo Loyalty tiers [coding challenge](https://tokyotreat.atlassian.net/wiki/external/ODJhODU1MGQ5NmMyNGFmNWFkOGI0YWZhMGI3MzI3OTM)  

The Frontend React application that consumes this API can be found [here](https://github.com/teslazonda/react-loyalty-tiers).

## Setup
* Ensure Ruby 3.2.2 and Rails 7 are installed.
* Clone the repo and navigate to the this project's root directory.
* Run `bundle install` to install Rails dependencies.
* Run `rails db:create && rails db:migrate` to locally setup the SQLite database.
* Start the server with `rails s`.


## Endpoints
All endpoints are part of the `v1` namespace.

* GET `v1/customers/{customer_id}`
* GET `v1/customers/{customer_id}/orders`
* POST `v1/orders`

### Requests and Responses
GET `v1/customers/{customer_id}`  
Fetch a customer's data.

```bash
curl -X GET http://localhost:3000/v1/customers/{customer_id}
```
```json
{"id":1,"current_tier":"GOLD","amount_spent_since_last_year":388670,"amount_needed_for_next_tier":null,"downgraded_tier":"SILVER","amount_needed_to_avoid_downgrade":-338670,"name":"Taro Suzuki","created_at":"2024-02-03T09:58:40.142Z","updated_at":"2024-02-03T10:11:46.097Z"}
```


GET `v1/customers/{customer_id}/orders`  
Fetch all orders made by a customer.
```bash
curl -X GET http://localhost:3000/v1/customers/{customer_id}/orders
```
```json
[{"id":2,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T245","totalInCents":4247,"date":"2024-01-09T02:02:02.530Z","created_at":"2024-02-03T09:58:40.776Z","updated_at":"2024-02-03T09:58:40.776Z"},{"id":10,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T872","totalInCents":9705,"date":"2024-01-07T14:44:03.882Z","created_at":"2024-02-03T09:58:40.966Z","updated_at":"2024-02-03T09:58:40.966Z"},{"id":12,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T672","totalInCents":7738,"date":"2024-01-02T22:38:15.784Z","created_at":"2024-02-03T09:58:41.012Z","updated_at":"2024-02-03T09:58:41.012Z"},{"id":18,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T587","totalInCents":8231,"date":"2024-01-21T13:19:55.242Z","created_at":"2024-02-03T09:58:41.159Z","updated_at":"2024-02-03T09:58:41.159Z"},{"id":20,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T912","totalInCents":2735,"date":"2024-01-07T17:53:46.405Z","created_at":"2024-02-03T09:58:41.206Z","updated_at":"2024-02-03T09:58:41.206Z"},{"id":25,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T167","totalInCents":7434,"date":"2024-01-21T07:18:10.833Z","created_at":"2024-02-03T09:58:41.329Z","updated_at":"2024-02-03T09:58:41.329Z"},{"id":33,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T343","totalInCents":3536,"date":"2024-01-18T01:42:26.092Z","created_at":"2024-02-03T09:58:41.528Z","updated_at":"2024-02-03T09:58:41.528Z"},{"id":51,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T43343","totalInCents":345044,"date":"2024-01-04T05:29:59.850Z","created_at":"2024-02-03T10:11:46.089Z","updated_at":"2024-02-03T10:11:46.089Z"}]
```

POST `v1/orders`  
Add a new order to a customer's list of orders.

```bash
curl -X POST -H "Content-Type: application/json" -d '{"customerId": "1", "customerName": "Taro Suzuki", "orderId": "T43333", "totalInCents": 34504, "date": "2024-01-04T05:29:59.850Z"}' http://localhost:3000/v1/orders
```
```json
{"id":52,"customer_id":1,"customerId":"1","customerName":"Taro Suzuki","orderId":"T43333","totalInCents":34504,"date":"2024-01-04T05:29:59.850Z","created_at":"2024-02-04T08:02:20.348Z","updated_at":"2024-02-04T08:02:20.348Z"}
```

## Notes
### Working with the API
* When testing the API, note that after the first database seed during setup, the `Customer` in the database will have an `customer_id` of `1`. After multiple database seedings this value will change. Check in the rails console with `Customer.first` to confirm the current `customer_id` to use for API requests.

* I've built the [React frontend](https://github.com/teslazonda/react-loyalty-tiers) assuming this Rails API is running on port `3000`.

* Rails and React both start on port `3000`. Running both from the same port however, is not possible. Starting the Rails app first, then starting the React app is good practice, as the React app will ask to start on another port, usually port `3001` 

### Tests

* You can run Rspec unit tests with `bundle exec rspec`. Some of these tests will fail. If I had more time I'd like to fix them.

### What's different from the requirements
* The API calculates a customer's tier based on orders made from the current year. This differs from the requirements

* The `amount_needed_to_avoid_downgrade` field in the Customer model does not function as per the requirements. These values should be ignored.


# Instructions for this project
[Requirements](https://tokyotreat.atlassian.net/wiki/external/ODJhODU1MGQ5NmMyNGFmNWFkOGI0YWZhMGI3MzI3OTM)


Imagine we already have a service which manages the customers and orders for an e-commerce site, and now we want to add a loyalty program with Bronze/Silver/Gold tiers. These tiers will be based on how much the customer has spent on our site since the start of last year.

    🥉 Bronze = default tier, from $0 spent

    🥈 Silver = at least $100 spent since the start of last year

    🥇 Gold = at least $500 spent since the start of last year

For example, if the date is 2022-03-01, the tier should be based on the customer's spending since 2021-01-01. If they spent $100 on 2021-06-01, then they are currently in the 🥈 Silver tier, but they will be downgraded to 🥉 Bronze on 2023-01-01 because they haven't spent anything in 2022.

You should build

    A backend API that computes each customer's current tier based on receiving order data in a webhook, and exposes data about the tier

    A frontend app that displays information about the customer's tier status

Backend API

This can be built in a language/framework of your choice (but we use Rails and Node.js, so ideally something similar to those!)

Data should be stored in a database engine of your choice (meaning SQLite, PostgreSQL, MySQL, MongoDB, or some other engine, instead of files or an in-memory database).

Try to avoid using third party libraries apart from the framework itself and commonly used utility libraries.

Requirements

    An endpoint we can call to report a completed order, which should save the order in a database and recalculate the customer's tier. The body of this request will be in the form: { "customerId": "123", "customerName": "Taro Suzuki", "orderId": "T123", "totalInCents": 3450, "date": "2022-03-04T05:29:59.850Z" }

    A way to recalculate the current tier of each customer at the end of each year (for example, you could create a cron job and give instructions of how and when to execute it)

    An endpoint which returns information about a customer when given their ID. It should return at least the customer's

        Current tier

        Start date of the tier calculation (i.e. start of last year - note that this is the same for all customers)

        Amount spent since that start date

        Amount that must be spent in order to reach the next tier

        The tier the customer will be downgraded to next year, if they don't spend any more (for example, a customer who spent $100 last year is currently Silver, but will be downgraded to Bronze from next year)

            This should be null if the customer has spent enough this year to maintain their current tier next year

        The date of the downgrade (i.e. end of this year - note that this is the same for all customers)

        How much the customer needs to spend this year in order to avoid being downgraded (or zero if they will maintain their current tier next year)

    An endpoint which lists the customer's orders since the start of last year, including the order ID, date and order total

Frontend app

This can be built as a single-page web app (with any modern framework such as React, Vue, etc) or a mobile app (native, React Native or Flutter) or a normal rails frontend(if it was for Rails backend position).

Try to avoid using third party libraries apart from the framework itself and commonly used utility libraries. If you build a web app, please write plain CSS instead of using a CSS framework.

Requirements

    A page which displays information from endpoint (3) above. This can be displayed however you like, but it must include a progress bar showing the customer's progress towards the next tier (e.g. if the customer spent $200, they are in the Silver tier and are 40% of the way to Gold)

    A page which displays the customer's order history from endpoint (4) above. Bonus points for pagination!

The customer ID should be passed in the URL for both pages (either path parameter or query parameter).

Finally, bear in mind we're looking for quality over quantity; we'd be happier to review a well-written solution that doesn't quite cover all the points rather than a fully working but hard-to-understand project! As such, feel free to include any explanatory comments or documentation you feel would help us understand your process.
