class RobotAnalytics

  def self.data
    {avg_years: avg_years}
  end

  def self.years
    RobotRegistry.all.map{|bot_obj| bot_obj.data[:operational] || bot_obj.data["operational"] }
  end

  def self.avg_years
    proper_entries = years.reject{|year| year.to_i.to_s != year}
    proper_entries.reduce(:+)/proper_entries.length
  end

  def self.totals
    RobotRegistry.all.reduce({branch_totals:Hash.new(0) ,city_totals: Hash.new(0), state_totals: Hash.new(0)}) do |acc, robot|
      acc[:branch_totals][robot.data[:branch]] += 1
      acc[:city_totals][robot.data[:city]] += 1
      acc[:state_totals][robot.data[:state]] += 1
    end
  end
end


# def init_params(n)
#     { :name=>"name#{n}",
#       :city=>"city#{n}",
#      :state=>"state#{n}",
# :operational=>"operational#{n}",
#    :weapons=>"weapons#{n}",
#     :branch=>"branch#{n}" }
# end
