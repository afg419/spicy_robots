class User
  attr_reader :username, :password

  def initialize(data = Hash.new(0))
    @username = data[:username]
    @password = data[:password]
  end

end
