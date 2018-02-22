# coding: utf-8
require 'capybara/dsl'
require 'capybara/rspec'

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.include Capybara::DSL
end
