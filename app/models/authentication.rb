require 'yaml/store'

class Authentication

  def self.database
    if ENV["RACK_ENV"] == "test"
      @database ||= Sequel.sqlite("db/user_password_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/user_password_development.sqlite3")
    end
  end

  def self.create(user_input)
    database.from(:user_password).insert(user_input)
  end

  # def self.find(id)
  #   Robot.new(database.from(:robots).where(id: id).to_a[0])
  # end

  def self.all
    database.from(:user_password).to_a.map{|user| User.new(user)}
  end

  # def self.update(id, params)
  #   database.from(:robots).where(id: id).update(params)
  # end

  def self.delete(id)
    database.from(:user_password).where(id: id).delete
  end

  # def self.find_by(demo,value)
  #   all.select{|robo_obj| robo_obj.data[demo].downcase == value}
  # end

end
