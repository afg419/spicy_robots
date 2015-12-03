ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/test'
require 'minitest/autorun'
require 'capybara'

Capybara.app = RobotControl

class Minitest::Test
  def teardown
    RobotRegistry.delete_all
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
