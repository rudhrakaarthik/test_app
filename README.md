Prepare for development
=======================

RVM
---

Install [RVM](https://rvm.io). After changing current directory to project
it will setup ruby and gemset according to files `.ruby-version` and `.ruby-gemset`

Getting Started
---------------

* `$ git clone git@github.com:rudhrakaarthik/test_app.git`
* `$ cd ./test_apps`
* `$ bundle install`

## Deployment
### Setup

To setup heroku deployments, run the following command(s):

    git remote add production git@github.com:rudhrakaarthik/test_app.git


Also for twitter API, please add the following details in heroku ENV variables,


    heroku config:add CONSUMER_KEY=sample_key
    heroku config:add CONSUMER_SECRET=sample_key
    heroku config:add ACCESS_TOKEN=sample_key
    heroku config:add ACCESS_SECRET=sample_key


### Procedure

Run the following commands to deploy:

    git push production <branch to deploy:>master


Servers
=======

* Production server: `http://intense-brook-7616.herokuapp.com/`



