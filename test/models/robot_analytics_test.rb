require_relative '../test_helper'

class RobotAnalyticsTest < Minitest::Test

  def create_all_different(num)
    (0..num).to_a.map do |n|
      RobotRegistry.create(params.zip(vals(n)).to_h)
    end
  end

  def create_with_same_year(num,year)
    (0..num).to_a.map do |n|
      RobotRegistry.create(params.zip(year_vals(n,year)).to_h)
    end
  end

  def create_with_same_demos(num,city,state,branch)
    (0..num).to_a.map do |n|
      RobotRegistry.create(params.zip(csb_vals(n,city,state,branch)).to_h)
    end
  end

  def test_the_truth
    assert 1+1 == 2
  end

  def test_returns_years
    create_all_different(3)
    expected = %w{operational1 operational2 operational3 operational4}
    assert_equal expected, RobotAnalytics.years
  end

  def test_returns_repeat_year
    create_with_same_year(3, 1880)
    expected = %w{1880 1880 1880 1880}
    assert_equal expected, RobotAnalytics.years
  end

  def test_computes_average_birth_year
    create_with_same_year(3, 2000)
    create_with_same_year(3, 1900)
    create_with_same_year(3, "bad data")

    assert_equal 1950, RobotAnalytics.avg_years
  end

  def test_returns_same_totals
    create_with_same_demos(3,"Pittsburgh","PA","AirForce")
    expected = {city_totals:{"pittsburgh" => 4},
                state_totals:{"pa" => 4},
                branch_totals:{"airforce" => 4}}
    assert_equal expected, RobotAnalytics.totals
  end

  def test_returns_totals
    create_with_same_demos(2,"Pittsburgh","PA","AirForce")
    create_with_same_demos(2,"Philadelphia","PA","Navy")
    expected = {city_totals:{"pittsburgh" => 3, "philadelphia" => 3},
                state_totals:{"pa" => 6},
                branch_totals:{"airforce" => 3, "navy" => 3}}
    assert_equal expected, RobotAnalytics.totals
  end

  def test_returns_data
    create_with_same_demos(2,"Pittsburgh","PA","AirForce")
    create_with_same_demos(2,"Philadelphia","PA","Navy")
    create_with_same_year(3, 2000)
    create_with_same_year(3, 1900)

  expected = {
   :avg_years=>1950,
   :branch_totals=>
          {"airforce"=>3, "navy"=>3, "branch1"=>2, "branch2"=>2, "branch3"=>2, "branch4"=>2},
   :city_totals=>
          {"pittsburgh"=>3, "philadelphia"=>3, "city1"=>2, "city2"=>2, "city3"=>2, "city4"=>2},
   :state_totals=>
          {"pa"=>6, "state1"=>2, "state2"=>2, "state3"=>2, "state4"=>2}
  }

    assert_equal expected, RobotAnalytics.data
  end
end
