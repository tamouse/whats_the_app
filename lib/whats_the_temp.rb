# frozen_string_literal: true

require_relative "whats_the_temp/version"
require_relative "whats_the_temp/weather_api"
require_relative "whats_the_temp/cli"

module WhatsTheTemp
  USAGE = %(
WEATHER: Provides the current temperature in Fahrenheit for the given address.

USAGE: weather [-h | --help | <address>]

-h, --help: show this usage document
<address>: show the temperature in Fahrenheit for the given address where address can be one of:
  - zip or postal code
  - city name
  - lat,long
  - IP address

)

  class Error < StandardError; end
end
