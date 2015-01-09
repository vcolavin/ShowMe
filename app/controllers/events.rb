get '/events' do
  @artist_name = params[:artist]

  @events_for_artist_in_radius = build_list_of_events(
    events:           events_for_artists(@artist_name),
    local_latitude:   params[:latitude].to_f,
    local_longitude:  params[:longitude].to_f,
    radius:           100
  )

  erb :events
end



get '/users/:user_id/events' do

  # FIXME: That's some ugly code right below me
  # It's to get the artist names rather than the artist objects.
  list_of_artists = User.find(params[:user_id]).artists.map {|artist| artist.name}
  local_latitude = params[:latitude].to_f
  local_longitude = params[:longitude].to_f

  if list_of_artists

    @all_events_in_radius = build_list_of_events(
      events:           events_for_artists(list_of_artists),
      local_latitude:   local_latitude,
      local_longitude:  local_longitude,
      radius:           100
    )

    erb :all_events
  end
end
