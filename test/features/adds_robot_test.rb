require_relative '../test_helper'

class AddsRobotTest < FeatureTest

  def test_a_user_can_add_a_robot
    visit('/')
    click_link_or_button('add_new')

    assert_equal '/robotregistry/new', current_path

    fill_in('robot[name]', with: "X1")
    fill_in('robot[city]', with: "X2")
    fill_in('robot[state]', with: "X3")
    fill_in('robot[operational]', with: "X4")
    fill_in('robot[weapons]', with: "X5")
    fill_in('robot[branch]', with: "X6")

    click_link_or_button('submit')

    assert_equal '/robotregistry', current_path

    within('#robot_links') do
      assert page.has_css?("#X1")
    end

    click_link_or_button("X1")

    within('#robot_data') do
      (1..6).each do |num|
        assert page.has_content?("X#{num}")
      end
    end

  end

end
