ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/test'
require 'minitest/autorun'
require 'capybara'

Capybara.app = RobotControl
DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/robot_registry_test.sqlite3")}].strategy = :truncation


class Minitest::Test

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def params
    [:name,:city,:state,:operational,:weapons,:branch]
  end

  def vals(n)
    ["name#{n+1}","city#{n+1}","state#{n+1}","operational#{n+1}","weapons#{n+1}","branch#{n+1}"]
  end

  def csb_vals(n,city,state,branch)
    ["name#{n+1}","#{city}","#{state}","operational#{n+1}","weapons#{n+1}","#{branch}"]
  end

  def year_vals(n,year)
    ["name#{n+1}","city#{n+1}","state#{n+1}","#{year}","weapons#{n+1}","branch#{n+1}"]
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
