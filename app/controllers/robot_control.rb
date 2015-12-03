class RobotControl < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true # <-- allows for _method stuff to override and make put and delete methods

  get '/' do
    erb :dashboard
  end

  get '/robotregistry' do
    @robots = RobotRegistry.all
    erb :registry
  end

  get '/robotregistry/new' do
    erb :registration
  end

  post '/robotregistry/new' do
    @robot = RobotRegistry.create(params[:robot])
    redirect '/robotregistry'
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
