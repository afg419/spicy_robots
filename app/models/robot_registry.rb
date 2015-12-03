require 'yaml/store'

class RobotRegistry

  def self.database
    if ENV["RACK_ENV"] == "test"
      @database ||= Sequel.sqlite("db/robot_registry_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_registry_development.sqlite3")
    end
  end

  def self.create(robot)
    database.from(:robots).insert(robot.merge(avatar_id:rand(1..100)))
  end

  def self.find(id)
    Robot.new(database.from(:robots).where(id: id).to_a[0])
  end

  def self.all
    database.from(:robots).to_a.map{|bot| Robot.new(bot)}
  end

  def self.update(id, params)
    database.from(:robots).where(id: id).update(params)
  end

  def self.delete(id)
    database.from(:robots).where(id: id).delete
  end

end
