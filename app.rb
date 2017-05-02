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
  flash[:notice] = "You're now signed in as #{user.username}!"
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

get '/meetups/show/:name' do
  if current_user
    @selected_meetup = params[:name]
    @selected_meetup = Meetup.where("name = ?", "#{@selected_meetup}")
    @selected_meetup = @selected_meetup[0]
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

get '/meetups/new' do
  if current_user
    erb :'meetups/new'
  else
    flash[:notice] = "Please sign in, no user logged in."
    redirect '/'
  end
end

post '/meetups/new' do
  name = params[:name]
  
end
