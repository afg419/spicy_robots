class Robot
  attr_reader :data

  def initialize(data = {})
    @data = data

    # @data.keys.map(&:to_sym).each do |attribute|
    #   self.class.send(:define_method,attribute) {data[attribute.to_s]}
    # end
    #
    # @data.keys.each do |attribute|
    #   self.class.send(:define_method,(attribute + "=").to_sym) {|x| data[attribute.to_s] = x}
    # end
  end

end

# NAME: <li><input type="text" name="robot[name]" value=""><br></li>
# CITY: <li><input type="text" name="robot[city]" value=""><br></li>
# STATE: <li><input type="text" name="robot[state]" value=""><br></li>
# AVATAR: <li><input type="text" name="robot[avatar]" value=""><br></li>
# OPERATIONAL_DATE: <li><input type="text" name="robot[operational]" value=""><br></li>
# WEAPONS: <li><input type="text" name="robot[weapons]" value=""><br></li>
# MILITARY_BRANCH:<li><input type="text" name="robot[branch]" value=""><br></li>
