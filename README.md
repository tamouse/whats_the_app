# WhatsTheTemp

A Ruby CLI app to show the current temperature for a given "address".

_(Note that "address" is sort of ambiguous intentionally)_

## prerequisites

- Ruby 3.2.x
- An API key from <https://www.weatherapi.com/>. This involves signing up for a free account, and they will give you the API key.
- Make sure the environment variable `WEATHER_API_KEY` is set to the value of your API key and exported in the environment.

## Installation

Install the app by cloning it from <https://github.com/tamouse/whats_the_temp> and running bundler to install everything.

    git clone 'https://github.com/tamouse/whats_the_temp.git'
    cd whats_the_temp
    bundle install
    export WEATHER_API_KEY=<your-weatherapi-key>

## Usage

First usage, just run the bin at `exe/whats_the_temp`:

    bundle exec exe/whats_the_temp 

This will print out the full usage for the app. The usage display is also available in the usual ways:

    bundle exec exe/whats_the_temp -h
    bundle exec exe/whats_the_temp --help 

### examples

    bundle exec exe/whats_the_temp 95112 # => "The current temp at 95112 is at 51.8 degrees Fahrenheit"
    bundle exec exe/whats_the_temp 'San Jose' # => "The current temp at San Jose is at 51.8 degrees Fahrenheit"

## Development

After checking out the repo, run `bundle install` to install all the dependencies.

Run the tests with `bundle exec rake`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tamouse/whats_the_temp.

