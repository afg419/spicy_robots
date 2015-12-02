require 'yaml/store'
require_relative 'robot'

class RobotRegistry

  def self.database
    @database ||= YAML::Store.new("db/robot_registry")
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['next_id'] ||= 0
      database['next_id'] += 1
      database['robots'] << {"id" => database['next_id']}.merge(robot)
    end
  end

  def self.find(id)
    all.find { |bot_obj| bot_obj.data["id"] == id }
  end

  def self.raw_bots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_bots.map {|bot| Robot.new(bot)}
  end

  def self.update(id, params)
    database.transaction do
      temp = database['robots'].find{|bot| bot["id"] == id }
      temp.each do |attribute, value|
        temp[attribute] = params[attribute] unless attribute == "id"
      end
    end
  end

  def self.delete(id)
    p "MADE IT TO DELETE"
    database.transaction do
      p "Before:"
      p database['robots']
      database['robots'].delete_if{|bot| bot['id'] == id}
      p "After:"
      p database['robots']
    end
  end

end
