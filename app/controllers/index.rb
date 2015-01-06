get '/' do
  @errors = flash[:errors] if flash[:errors]
  erb :home
end

get '/events' do
  lastfm = Lastfm.new(ENV['LASTFM_KEY'], ENV['LASTFM_SECRET'])

  @artist_info = lastfm.artist.get_info(
    :artist => params[:artist]
  )

  @events_for_artist = lastfm.artist.get_events(
    :artist => params[:artist],
    :limit => 100
  )

  @events_in_radius = lastfm.geo.get_events(
      :lat => params[:latitude],
      :long => params[:longitude],
      :distance => 100,
      :limit => 500 # FIXME: This is a great way to get kicked off the API
    )

  # compare @events_for_artist and @events_within_radius to get their intersection
  if (@events_in_radius & @events_for_artist) != []
    @events_for_artist_in_radius = @events_in_radius & @events_for_artist
  end

  erb :events
end

post '/signup' do
  user = User.new(email: params[:email], pw_hash: params[:password])
  if user.save
    session[:used_id] = user.id # FIXME: Why doesn't this log the user in?
  else
    flash[:errors] = user.errors
  end
  redirect to '/'
end

post '/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
  else
    flash[:errors] = ["invalid email or password"]
  end
  redirect '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end
