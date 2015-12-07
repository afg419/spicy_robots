class CustomAuth < Rack::Auth::Basic
  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when '/'
      @app.call(env)  # skip auth
    else
      super         # perform auth
    end
  end
end

class RobotControl < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true # <-- allows for _method stuff to override and make put and delete methods

  use CustomAuth, "Restricted Area" do |username, password|
    a = Authentication.all
    a.map {|user_obj| user_obj.username == username && user_obj.password == password }.any?
  end

  get '/' do
    @analytics = RobotAnalytics.new
    a = Authentication.all
    erb :dashboard
  end

  post '/' do
    @authenticator = Authentication.create(params[:user_input])
    redirect '/'
  end

  get '/robotregistry' do

    @robots = RobotRegistry.all
    erb :registry, :locals => {:demographic => nil,
                               :demographic_value => nil}
  end

  get '/robotregistry/new' do

    erb :registration
  end

  post '/robotregistry/new' do
    @robot = RobotRegistry.create(params[:robot])
    redirect '/robotregistry'
  end

  get '/robotregistry/demographic/:demo/:val' do |demo, val|

    @robots = RobotRegistry.find_by(demo.to_sym, val)
    erb :registry, :locals => {:demographic => demo.to_sym,
                               :demographic_value => val}
  end

  get '/robotregistry/:id' do |id|
    @robot = RobotRegistry.find(id.to_i)
    erb :single
  end

  get '/robotregistry/:id/update' do |id|
    @robot = RobotRegistry.find(id.to_i)
    erb :update
  end

  put '/robotregistry/:id' do |id|
    RobotRegistry.update(id.to_i, params[:robot])
    redirect '/robotregistry'
  end

  delete '/robotregistry/:id' do |id|
    RobotRegistry.delete(id.to_i)
    redirect '/robotregistry'
  end
end
