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
