require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/listing_repo'
require_relative './lib/database_connection'
require_relative './lib/user_repo'

DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    repo = ListingRepository.new

    @listings = repo.all

    return erb(:index)
  end

  get '/login' do
    return erb(:login)
  end 
  
  post '/login' do
    repo = UserRepository.new

    outcome = repo.all

    user = repo.find_by_email(params[:email])
    if outcome.include?(user)
      user_password = user.password
      if repo.valid_password?(user_password, params[:password]) == "success"
        session[:user_id] = user.id
        redirect '/'
      else  
        redirect '/login'
      end    
    else 
      redirect '/login'
    end
  end  
end