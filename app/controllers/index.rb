get '/' do
  @errors = flash[:errors] if flash[:errors]
  erb :splash
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
  else
    flash[:errors] = user.errors
  end
  redirect "/users/#{@user.id}"
end

get '/login' do
  @errors = flash[:errors] if flash[:errors]
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:email])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
  else
    flash[:errors] = ["invalid email or password"]
  end
  redirect "/users/#{@user.id}"
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
