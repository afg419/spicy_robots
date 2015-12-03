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

  def params
    [:name,:city,:state,:operational,:weapons,:branch].map(&:to_s)
  end

  def vals(n)
    ["name#{n+1}","city#{n+1}","state#{n+1}","operational#{n+1}","weapons#{n+1}","branch#{n+1}"]
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
