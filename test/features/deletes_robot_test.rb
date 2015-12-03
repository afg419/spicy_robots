require_relative '../test_helper'

class DeletesRobotTest < FeatureTest

  def test_a_user_can_delete_a_robot
    id = RobotRegistry.create(params.zip(vals(0)).to_h)
    visit('/robotregistry')

    within('#robot_links') do
      assert page.has_css?("#name1")
    end

    click_link_or_button("delete#{id}")

    within('#robot_links') do
      refute page.has_css?("#name1")
    end
  end

end
