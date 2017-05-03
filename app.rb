require 'sinatra'
require_relative 'config/application'
require 'date'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end

  def all_meetups
    Meetup.all.sort { |a, b| a.name <=> b.name }
  end

end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  if user.username.nil?
    flash[:notice] = "Login Error occurred!"
  else
    flash[:notice] = "You're now signed in as #{user.username}!"
  end
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  erb :'meetups/index'
end

get '/meetups/:id' do
  if current_user
    id = params[:id]
    @selected_meetup = Meetup.find(id)
    if !@selected_meetup.start_time.nil?
      @start_time = @selected_meetup.start_time.strftime("%m/%d/%y %I:%M%p")
    end
    if !@selected_meetup.end_time.nil?
      @end_time = @selected_meetup.end_time.strftime("%m/%d/%y %I:%M%p")
    end
    erb :'meetups/show'
  else
    flash[:notice] = "Please sign in, no user logged in."
    redirect '/'
  end

end

get '/meetup/create' do
  if current_user
    erb :'meetups/new'
  else
    flash[:notice] = "Please sign in, no user logged in."
    redirect '/'
  end
end

post '/meetup/create' do
  name = params[:name]

end
