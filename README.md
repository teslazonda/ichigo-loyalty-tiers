# README

## Setup
* Ensure Ruby 3.2.2 and Rails 7 are installed
* Clone the repo and navigate to the this projects root directory
* Run `bundle install` to install Rails dependencies
* Run `rails db:create && rails db:migrate` to locally setup the SQLite database
* Start the server with `rails s`


Requirements

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

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
