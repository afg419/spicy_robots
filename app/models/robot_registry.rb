require 'yaml/store'

class RobotRegistry

  def self.database
    if ENV['RACK_ENV'] == 'test'
      @database ||= YAML::Store.new("db/robot_registry_test")
    else
      @database ||= YAML::Store.new("db/robot_registry")
    end
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['next_id'] = rand(0..100)
      database['robots'] << {"id" => database['next_id']}.merge(robot)
      database['next_id']
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
      Robot.new(temp)
    end
  end

  def self.delete(id)
    database.transaction do
      database['robots'].delete_if{|bot| bot['id'] == id}
    end
  end

  def self.delete_all
    database.transaction do
      database['robots'] = []
    end
  end

end
