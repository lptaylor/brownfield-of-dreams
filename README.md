# Brownfield Of Dreams

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

This project used the base repo linked below. The added functionality includes:

Deploying to Heroku: https://warm-stream-34176.herokuapp.com/
Connecting our users' account to their Github account. Then displaying their Github information (Repos, Followers and Following) in their Dashboard, all which link out to Github.
Using Github Omniauth to allow our users to connect their Github account to our app.
Create friendships between our users. A user can choose to add a friend who is already in our database and is listed in their Following or Followers on Github section.
A User can bookmark videos. Those videos are then listed on their dashboard and link out to the tutorial page.
A non-logged in User can not see Classroom Content.
All added videos are set to an default position on the page. 
A tutorial will not load if there are no videos associated with that tutorial.
After registering for our app, the user is prompted to visit their email to receive an activation link. Their account is marked as inactive until they activate it via the emailed link.
A user can invite any Github user, via their Github handle, to join our app. Inviting a Github user will send them a link to our registration page.
Project Spec, Evaluation Rubric, and Base Code for a brownfield project used at Turing for Backend Mod 3.: https://github.com/turingschool-examples/brownfield-of-dreams

## Local Setup

First you'll need to setup an API key with YouTube and have it defined within ENV['YOUTUBE_API_KEY'], an API key with Github and have it defined within ENV['GITHUB_API_KEY'], and an API key with SendGrid or your desired email provider. Observe User facotry to view correct naming for the Yamel file.

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
