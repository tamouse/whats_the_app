# frozen_string_literal: true

# weather_ap_test file for weather_api

require "test_helper"

module WhatsTheTemp
  class TestWeatherApi < Minitest::Test
    def test_create_url
      w = WhatsTheTemp::WeatherApi.new

      assert_equal "http://api.weatherapi.com/v1?key=d83c18de62814e559d1143220240404&q=55118", w.create_url("55118")
    end
  end
end
