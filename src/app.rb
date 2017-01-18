require 'sinatra'
require 'sinatra/reloader'

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

    if name == 'test1' && pass == 'pass'
      session[:name] = name
      redirect '/'
    else
      redirect '/login'
    end
  end

  post '/logout' do
    session[:name] = nil
    redirect '/login'
  end
end
