# frozen_string_literal: true

require 'dry/credentials'
require_relative "whats_the_temp/version"


module WhatsTheTemp
  extend Dry::Credentials

  credentials do
    env "sandbox"
    dir "."
  end

  class Error < StandardError; end
  # Your code goes here...
end
