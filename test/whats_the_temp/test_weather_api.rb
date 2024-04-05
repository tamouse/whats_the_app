# frozen_string_literal: true

# weather_ap_test file for weather_api

require "test_helper"
require "json"
require "vcr"

module WhatsTheTemp
  class TestWeatherApi < Minitest::Test
    def setup
      @w = WhatsTheTemp::WeatherApi.new
      @zip = "55118" # St. Paul, MN

      VCR.configure do |c|
        c.cassette_library_dir = "test/fixtures/vcr_cassettes"
        c.hook_into :webmock
      end
    end

    def test_current_temp_for
      VCR.use_cassette "current_temp_for" do
        weather = @w.current_temp_for(@zip)
        refute_nil weather
      end
    end

    def test_create_url
      assert_equal  "http://api.weatherapi.com/v1/current.json?key=#{WhatsTheTemp::WeatherApi::API_KEY}&q=55118&aqi=no",
                    @w.send(:create_url, @zip).to_s
    end

    def test_get_weather_for
      VCR.use_cassette "get_weather_for" do
        response = @w.send :get_weather_for, @zip
        refute_nil response
        assert_equal "Saint Paul", response.dig("location", "name")
      end
    end
  end
end
