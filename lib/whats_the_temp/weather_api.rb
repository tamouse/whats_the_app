# frozen_string_literal: true

# lib/weather_api.rb

require "uri"
require "net/http"
require "json"

module WhatsTheTemp
  # Client for the weatherapi.com API
  class WeatherApi
    API_KEY = "d83c18de62814e559d1143220240404" # Normally, you should put this into an encrypted file
    BASE_URL = "http://api.weatherapi.com/v1/current.json"

    # @return [Float] the current temperature in Fahrenheit
    # @param [String] address - An appropriate string to indicate the location to return the weather
    # @note The address can be a zip or postal code, a city name, IP address, or more
    # @see <https://www.weatherapi.com/docs/#intro-request> for more details on what the address can contain
    def current_temp_for(address)
      weather = get_weather_for(address)
      weather.dig("current", "temp_f")
    end

    private

    def get_weather_for(address)
      url = create_url(address)
      JSON.parse(Net::HTTP.get(url))
    end

    def create_url(query)
      uri = URI(BASE_URL)
      qs = URI.encode_www_form(key: API_KEY, q: query, aqi: "no")
      uri.query = qs
      uri
    end
  end
end
