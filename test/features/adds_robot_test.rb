require_relative '../test_helper'

class WelcomePageTest < FeatureTest

  def test_a_user_can_add_a_robot
    visit('/')

    assert_equal '/', current_path
  end

end
