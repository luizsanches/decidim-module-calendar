# Decidim::EventCalendar

[![Ruby](https://github.com/luizsanches/decidim-module-calendar/actions/workflows/tests.yml/badge.svg)](https://github.com/luizsanches/decidim-module-calendar/actions/workflows/tests.yml)
[![Test Coverage](https://api.codeclimate.com/v1/badges/bb5ce03c560a0d5bd032/test_coverage)](https://codeclimate.com/github/luizsanches/decidim-module-calendar/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/bb5ce03c560a0d5bd032/maintainability)](https://codeclimate.com/github/luizsanches/decidim-module-calendar/maintainability)

This [Decidim](https://github.com/decidim/decidim) module enable a multitenant
global calendar for Consultations, Debates, External Events, Meetings and
Participatory Processes. Giving a snapshot of all current activities in a
calendar view form.

![decidim-calendar](docs/decidim-calendar.png)

## Features

- Display past and future events in from of calendar and agenda.
- Display gantt graph of participatory processes
- Download ICAL for import

## Instalation

Edit the Gemfile and add this lines:

```ruby
gem "decidim-calendar", git: "https://github.com/luizsanches/decidim-module-calendar"
```

Run this rake tasks:

```bash
bundle exec rake decidim_event_calendar:install:migrations
bundle exec rake db:migrate
```

To keep the gem up to date, you can use the commands above to also update it.

## Contributing

For instructions how to setup your development environment for Decidim, see
[Decidim](https://github.com/decidim/decidim). Also follow Decidim's general
instructions for development for this project as well.

## Developing

Dependencies:

- [Docker](https://docs.docker.com/engine/install)

- [Docker Compose](https://docs.docker.com/compose/install)

Clone this repository or fork and run:

```bash
bundle install

docker-compose up -d

export DATABASE_USERNAME=postgres

bundle exec rake development_app
```

## Testing

Dependencies:

- [ChromeDriver](https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver)

Run the commands:

```bash
bundle exec rake test_app
bundle exec rake spec
```

## Localization

If you would like to see this module in your own language, you can help with
its translation at Crowdin:

[https://crowdin.com/project/decidim-calendar](https://crowdin.com/project/decidim-calendar)
