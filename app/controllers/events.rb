get '/events' do

  @events_for_artist_in_radius = build_list_of_events(
    events:           events_for_artist(@artist_name),
    local_latitude:   params[:latitude].to_f,
    local_longitude:  params[:longitude].to_f,
    radius:           100
  )

  erb :events
end



get '/users/:user_id/events' do
  list_of_artists = User.find(params[:user_id]).artists
  local_latitude = params[:latitude].to_f
  local_longitude = params[:longitude].to_f

  if list_of_artists
  lastfm = Lastfm.new(LASTFM_KEY, LASTFM_SECRET)

    all_shows = list_of_artists.map do |artist|
      lastfm.artist.get_events(
        :artist => artist.name,
        :limit  => 100
      )
    end
    all_shows.flatten!

    @all_events_in_radius = build_list_of_events(
      events:           all_shows,
      local_latitude:   local_latitude,
      local_longitude:  local_longitude,
      radius:           100
    )

    erb :all_events
  end
end
