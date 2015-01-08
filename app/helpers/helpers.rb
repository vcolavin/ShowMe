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

  def build_list_of_events(options = {})

    local_latitude  = options[:local_latitude]
    local_longitude = options[:local_longitude]
    events          = options[:events]
    radius          = options[:radius]

    events_for_artist_in_radius = events.map do |event|

      if (event['venue']['location']['point']['lat'] != {} &&
          event['venue']['location']['point']['lat'] != {})

        event_latitude  = event['venue']['location']['point']['lat'].to_f
        event_longitude = event['venue']['location']['point']['long'].to_f

        distance_from_point = Haversine.distance(
                                local_latitude,
                                local_longitude,
                                event_latitude,
                                event_longitude).to_km

        if (distance_from_point < radius)
          event # adds the event to @events_for_artist_in_radius
        else
          nil # TODO: Sometimes the venue is missing coordinates. In this case, we'll have to go to the Google API to find them from the address.
        end
      end
    end

  events_for_artist_in_radius.compact! # remove nils added in the map
  end

end
