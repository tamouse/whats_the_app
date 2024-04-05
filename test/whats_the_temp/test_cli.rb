# frozen_string_literal: true

require "test_helper"

module WhatsTheApp
  class TestCLI < Minitest::Test
    def setup
      @input = StringIO.new
      @output = StringIO.new
      @error = StringIO.new
      @options = {}
    end

    def test_handles_short_help_option
      argv = %w[-h]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      cli.call

      assert_equal WhatsTheTemp::USAGE, @error.string
    end

    def test_handles_long_help_option
      argv = %w[--help]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      cli.call

      assert_equal WhatsTheTemp::USAGE, @error.string
    end

    def test_handles_invalid_options
      argv = %w[--glitch]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      cli.call

      assert_equal "Invalid option #{argv.first.inspect}\n" + WhatsTheTemp::USAGE,
                   @error.string
    end

    def test_handles_zip_code
      argv = %w[60609]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      VCR.use_cassette "handles_zip_code" do
        cli.call
      end

      assert_match(/The current temp at #{argv.first} is at \d+(|\.\d+) degrees Fahrenheit/,
                   @output.string)
    end

    def test_handles_city_name
      argv = %w[Chicago]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      VCR.use_cassette "handles_city_name" do
        cli.call
      end

      assert_match(/The current temp at #{argv.first} is at \d+(|\.\d+) degrees Fahrenheit/,
                   @output.string)
    end

    def test_handles_no_arguments
      argv = %w[]
      cli = WhatsTheTemp::CLI.new(argv, @options, @input, @output, @error)
      cli.call

      assert_equal WhatsTheTemp::USAGE, @error.string
    end
  end
end
