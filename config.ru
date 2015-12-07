require File.expand_path('../config/environment',__FILE__)

# run Rack::URLMap.new({
#   "/" => RobotContorl,
#   "/protected" => RobotControl
# })

run RobotControl
