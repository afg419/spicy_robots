class User
  attr_reader :username, :password

  def initialize(data = Hash.new(0))
    @username = data[:name]
    @password = data[:password]
  end

end
