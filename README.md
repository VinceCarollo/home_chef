# HomeChef

App to track personal Chef home appointments

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- HomeBrew
- Postgresql
- Rbenv
- Node
- Overmind

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install postgresql rbenv node
brew install tmux
brew install overmind
```

### Installing

```
git clone https://github.com/VinceCarollo/home_chef.git

rbenv install 2.6.5
gem install bundler
bundle install
```

Database
```
rails db:create
rails db:migrate
```

Run
```
overmind start
```
and navigate to [http://localhost:5000](http://localhost:5000)

## Running the tests

```
bundle exec rspec
```

## Built With

* [Rails](https://rubyonrails.org/) - The web framework used
* [Bundler](https://bundler.io/) - Dependency Management
* [PostgreSQL](https://www.postgresql.org/) - Database
* [Figaro](https://github.com/laserlemon/figaro) - Env Vars
* [Overmind](https://github.com/DarthSim/overmind) - Process Manager


## Authors

* **Vince Carollo** - *Initial work* - [VinceCarollo](https://github.com/vincecarollo)