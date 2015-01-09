get '/' do
  @errors = flash[:errors] if flash[:errors]
  erb :splash
end

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  erb :logged_in_home
end

get '/events' do
  lastfm = Lastfm.new(ENV['LASTFM_KEY'], ENV['LASTFM_SECRET'])

  @artist_name = params[:artist]

  events_for_artist = lastfm.artist.get_events(
    :artist => @artist_name,
    :limit  => 100
  )

  # Build a list of artists within radius

  @events_for_artist_in_radius = build_list_of_events(
    events:           events_for_artist,
    local_latitude:   params[:latitude].to_f,
    local_longitude:  params[:longitude].to_f,
    radius:           100
  )

  erb :events
end

get '/signup' do
  @errors = flash[:errors] if flash[:errors]
  erb :signup
end

post '/signup' do
  user = User.new(email: params[:email])
  user.password = params[:password]
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{@user.id}"
  else
    flash[:errors] = user.errors
    redirect '/signup'
  end
end

get '/login' do
  @errors = flash[:errors] if flash[:errors]
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    flash[:errors] = ["invalid email or password"]
    redirect to 'login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
