# frozen_string_literal: true

# lib/weather_api.rb

require "uri"

module WhatsTheTemp
  # Client for the weatherapi.com API
  class WeatherApi
    API_KEY = "d83c18de62814e559d1143220240404" # Normally, you should put this into an encrypted file
    BASE_URL = "http://api.weatherapi.com/v1"

    def create_url(query)
      uri = URI(BASE_URL)
      qs = URI.encode_www_form(key: API_KEY, q: query)
      uri.query = qs
      uri.to_s
    end
  end
end
