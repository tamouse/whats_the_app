# frozen_string_literal: true

module WhatsTheTemp
  # CLI - handle the command line interface
  class CLI
    attr_reader :args, :options, :input, :output, :error, :address

    def self.call(...)
      new(...).call
    end

    # @param [Array<String>] args
    # @param [Hash] options
    # @param [IO] input
    # @param [IO] output
    # @param [IO] error
    # @return [WhatsTheTemp::CLI]
    def initialize(args = ARGV, options = {}, input = $stdin, output = $stdout, error = $stderr)
      @args = args
      @options = options
      @input = input
      @output = output
      @error = error
      @address = nil
    end

    def call
      return unless process_options(args.first)

      temp = process_address
      output.puts "The current temp at #{address} is at #{temp} degrees Fahrenheit"
    end

    private

    def process_options(arg)
      result = false
      if arg.nil? || arg == "-h" || arg == "--help"
        error.print WhatsTheTemp::USAGE
      elsif arg.match?(/^-+/)
        error.puts "Invalid option #{arg.inspect}\n"
        error.print WhatsTheTemp::USAGE
      else
        @address = arg
        result = true
      end
      result
    end

    def process_address
      WhatsTheTemp::WeatherApi.new.current_temp_for address
    end
  end
end
