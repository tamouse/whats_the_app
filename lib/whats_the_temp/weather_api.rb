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

    def current_temp_for(address)
      weather = get_weather_for(address)
      weather.dig("current", "temp_f")
    end

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
