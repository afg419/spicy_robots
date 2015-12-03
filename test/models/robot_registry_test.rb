require_relative '../test_helper'

class RobotRegistryTest < Minitest::Test

  def create_tasks(num)
    (0..num).to_a.map do |n|
      RobotRegistry.create(params.zip(vals(n)).to_h)
    end
  end



  def test_creates_robots
    ids = create_tasks(1)
    robot = RobotRegistry.find(ids[0])

    params.each do |param|
      assert_equal "#{param.to_s}1", robot.data[param]
    end
  end

  def test_all
    ids = create_tasks(3)
    all_tasks = RobotRegistry.all

    all_tasks.each_with_index do |robot, ind|
      assert robot.is_a?(Robot)
      params.each do |param|
        assert_equal "#{param.to_s}#{ind+1}", robot.data[param]
      end
    end
  end

  def test_find
    ids = create_tasks(3)

    ids.each_with_index do |i,ind|
      params.each do |param|
        assert_equal "#{param.to_s}#{ind+1}", RobotRegistry.find(i).data[param]
      end
    end
  end

  def test_update
    ids = create_tasks(3)

    robot2 = RobotRegistry.find(ids[1])
    robot3 = RobotRegistry.find(ids[2])

    robot2 = RobotRegistry.update(ids[1], {"name" => "Hank"})
    robot3 = RobotRegistry.update(ids[2], params.zip(vals(4)).to_h)

    assert_equal "Hank", robot2.data["name"]

    params.each do |param|
      assert_equal "#{param.to_s}#{5}", robot3.data[param]
    end
  end

  def test_destroy
    ids = create_tasks(3)
    RobotRegistry.delete(ids[1])

    assert_equal 3, RobotRegistry.all.length
  end
end
