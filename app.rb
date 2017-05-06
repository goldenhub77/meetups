require 'sinatra'
require_relative 'config/application'
require 'date'

set :bind, '0.0.0.0'  # bind to all interfaces

enable :sessions;

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end

  def all_sorted_meetups
    Meetup.all.sort { |a, b| a.name <=> b.name }
  end

end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do

  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  if user.valid?
    flash[:notice] = "You're now signed in as #{user.name}!"
  else
    flash[:notice] = "Login Error occurred!"
  end
  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  session[:name] = nil
  session[:location] = nil
  session[:start_date] = nil
  session[:start_time] = nil
  session[:end_date] = nil
  session[:end_time] = nil
  session[:description] = nil
  erb :'meetups/index'
end

get '/meetups/:id' do
  if current_user
    id = params[:id]
    @selected_meetup = Meetup.find(id)
    if !@selected_meetup.start_date.nil?
      @start_date= @selected_meetup.start_date.strftime("%a %h %e, %Y at %l:%M%p")
    end
    if !@selected_meetup.end_date.nil?
      @end_date = @selected_meetup.end_date.strftime("%a %h %e, %Y at %l:%M%p")
    end
    if session[:create_meetup]
      flash[:notice] = "Meetup saved successfully!"
      session[:create_meetup] = nil
      redirect "/meetups/#{params[:id]}"
    else
      erb :'meetups/show'
    end
  else
    flash[:notice] = "Please sign in, no user logged in."
    redirect '/'
  end

end

get '/meetup/create' do
  if current_user
    @start_min_date = Date.today();
    erb :'meetups/new'
  else
    flash[:notice] = "Please sign in, no user logged in."
    redirect '/'
  end
end

post '/meetup/create' do
  #will be used to turn form data into a DateTime object
  # DateTime.strptime('2001-03-02 04:05', '%Y-%m-%d %H:%M')

  #change Date object back to string
  # dateobj.strftime("%a %h %e, %Y at %l:%M%p")
  session[:name] = params[:name]
  session[:location] = params[:location]
  session[:start_date] = params[:start_date]
  session[:start_time] = params[:start_time]
  session[:end_date] = params[:end_date]
  session[:end_time] = params[:end_time]
  session[:description] = params[:description]

  if session[:start_date] != "" && session[:start_time] != ""
    session[:db_start_date] = DateTime.strptime("#{session[:start_date]} #{session[:start_time]}", '%Y-%m-%d %H:%M')
  end
  if session[:end_date] != "" && session[:end_time] != ""
    session[:db_end_date] = DateTime.strptime("#{session[:end_date]} #{session[:end_time]}", '%Y-%m-%d %H:%M')
  end

  meetup = Meetup.create({
    name: session[:name],
    location: session[:location],
    creator: current_user.username,
    description: session[:description],
    start_date: session[:db_start_date],
    end_date: session[:db_end_date]

    })

  if meetup.valid?
    session[:create_meetup] = true
    redirect "/meetups/#{meetup.id}"
  else
    session[:create_meetup] = false
    errors = "Meetup not saved - "
    meetup.errors.full_messages().each do |error|
      errors += error
    end
    flash[:notice] = errors
    redirect '/meetup/create'
  end
end
