# Viewing Party

### There is currently no live deployment of this application.

## About

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Mainly, your job is to connect with an external API and collect relevant information on each movie, its cast, and other information, to display it on each Viewing Party page. 

## Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far. 

When you run `bundle exec rspec`, you should have 26 passing tests (both features & models combined). 

### Use the application
`rails s`, navigate to `127.0.0.0:3000` and click around the site. 

## Versions

- Ruby 3.2.2
- Rails 7.1.2

Example wireframes to follow are found [here](https://backend.turing.edu/module3/projects/viewing_party_solo/wireframes)

## Requirements

### Evaluation Rubric

[Link to Evaluation Rubric](https://backend.turing.edu/module3/projects/viewing_party_solo/rubric)

- [ ] All core requirements are complete
- [ ] Project achieves 90% or greater test coverage. In addition to “happy path”, project also includes “sad path”/edge case testing. Feature Tests stub external HTTP requests.
- [ ] Student can demonstrate how API consumption portions of the project demonstrate 2 of pillars listed below. Student can identify areas where code can be refactored. Student has refactored into facade and service design pattern.

Four Pillars of Object Oriented Programming
* Polymorphism
* Encapsulation
* Abstraction
* Inheritance

### Feedback Evaluation

[Link to Feedback Evaluation Guide](https://backend.turing.edu/module3/projects/viewing_party_solo/evaluation)

* Feedback Request: Choose at least one part of your project that you’d like specific feedback on. Everyone will be asked to bring this to the feedback session, and you will be able to get feedback from your instructor as well as your peers in the feedback group.
* Behavioral Question: After you’re done getting feedback on your code, your instructor will pull up the Wheel of Behavioral Interview Questions, and spin it to select a question for you to answer. This is meant to emulate an interview experience. So, as funny as it may feel, answer it as if you were talking to an interviewer. After answering, your instructor (and any cohort-mates!) will give you feedback on your answer. Remember, this is a safe place to practice!

### Consolidated User Story Progress

[Link to User Stories](https://backend.turing.edu/module3/projects/viewing_party_solo/requirements)

- [ ] User Story 0 - Setup
- [ ] User Story 1 - Discover Movies: Search by Title
- [ ] User Story 2 - Movie Results Page
- [ ] User Story 3 - Movie Details Page
- [ ] User Story 4 - New Viewing Party Page
- [ ] User Story 5 - Where to Watch
- [ ] User Story 6 - Similar Movies
- [ ] User Story 7 - Add Movie Info to User Dashboard

### Utilized Sad Paths

* An error is thrown...

### Tests

* 26 Tests Total (100% coverage on 139/139 LOC)
* 16 Model Tests (100% coverage on 84/84 LOC)
* 10 Feature Tests (99.05% coverage on 104/105 LOC)