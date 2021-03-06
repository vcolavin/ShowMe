helpers do
  def event_to_s(event)
    <<-heredoc
      #{event['venue']['location']['city']}. #{event['artists']['headliner']}. #{event['id']}. <a href="#{event['url']}">last.fm event page
      </a>


    heredoc
  end

  def current_user
    puts session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def events_for_artists(artists = [])

    # ensures that everything is a one-dimensional array
    artists = [artists].flatten

    lastfm = Lastfm.new(LASTFM_KEY, LASTFM_SECRET)
    events = []

    artists.each do |artist|
      events << lastfm.artist.get_events(
        :artist   => artist,
        :limit    => 100)
    end

    events.flatten
  end

  def build_list_of_events(options = {})

    local_latitude  = options[:local_latitude]
    local_longitude = options[:local_longitude]
    events          = options[:events] || []
    search_radius   = options[:search_radius]


    events_for_artist_in_search_radius = events.flatten.map do |event|

      if (event['venue']['location']['point']['lat'] != {} &&
          event['venue']['location']['point']['long'] != {})

        event_latitude  = event['venue']['location']['point']['lat'].to_f
        event_longitude = event['venue']['location']['point']['long'].to_f

        distance_to_event = Haversine.distance(
                                local_latitude,
                                local_longitude,
                                event_latitude,
                                event_longitude).to_km

        if (distance_to_event < search_radius)
          event
        else
          nil # TODO: Sometimes the venue is missing coordinates, like if the event is in Australia. In this case, go to the Google API to find them from the address.
        end
      end
    end

  events_for_artist_in_search_radius.compact # remove nils added in the map
  end

end
