require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'json'

# Sinatra Main controller
class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  use Rack::Session::Pool, expire_after: 2_592_000

  get '/' do
    @name = session[:name]
    if @name.nil?
      redirect 'login'
    else
      erb :main
    end
  end

  get '/login' do
    @title = 'login'
    erb :login
  end

  post '/login' do
    name = params[:name]
    pass = params[:password]

    if name == 'user' && pass == 'pass'
      session[:name] = name
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/user' do
    json(name: session[:name])
  end

  post '/reverse', provides: :json do
    json = JSON.parse(request.body.read, symbolize_names: true)
    json[:message].reverse
  end

  post '/logout' do
    session[:name] = nil
    redirect '/login'
  end
end
