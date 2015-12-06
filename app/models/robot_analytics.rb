class RobotAnalytics

  attr_reader :avg_years, :branch_totals, :city_totals, :state_totals

  def initialize
    @avg_years = avg_years
    @branch_totals = totals[:branch_totals]
    @city_totals = totals[:city_totals]
    @state_totals = totals[:state_totals]
  end

  def data
    {avg_years: avg_years}.merge(totals)
  end

  def years
    RobotRegistry.all.map{|bot_obj| bot_obj.data[:operational] || bot_obj.data["operational"] }
  end

  def avg_years
    proper_entries = years.reject{|year| year.to_i.to_s != year}
    if proper_entries.length > 0
      proper_entries.map(&:to_i).reduce(:+)/proper_entries.length
    else
      "N/A"
    end
  end

  def totals
    init_acc = {branch_totals:Hash.new(0) ,city_totals: Hash.new(0), state_totals: Hash.new(0)}
    RobotRegistry.all.reduce(init_acc) do |acc, robot|
      acc[:branch_totals][robot.data[:branch].downcase] += 1
      acc[:city_totals][robot.data[:city].downcase] += 1
      acc[:state_totals][robot.data[:state].downcase] += 1
      acc
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
