class RobotAnalytics

  def self.data
    {avg_years: avg_years}.merge(totals)
  end

  def self.years
    RobotRegistry.all.map{|bot_obj| bot_obj.data[:operational] || bot_obj.data["operational"] }
  end

  def self.avg_years
    proper_entries = years.reject{|year| year.to_i.to_s != year}
    if proper_entries.length > 0
      proper_entries.map(&:to_i).reduce(:+)/proper_entries.length
    else
      "N/A"
    end
  end

  def self.totals
    acc = {branch_totals:Hash.new(0) ,city_totals: Hash.new(0), state_totals: Hash.new(0)}
    RobotRegistry.all.each do |robot|
      acc[:branch_totals][robot.data["branch"].downcase] += 1
      acc[:city_totals][robot.data["city"].downcase] += 1
      acc[:state_totals][robot.data["state"].downcase] += 1
    end
    acc
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
