helpers do
  def event_to_s(event)
    <<-heredoc
      #{event['venue']['location']['city']}. #{event['artists']['headliner']}. #{event['id']}. <a href="#{event['url']}">last.fm event page</a>.
    heredoc
  end

  def current_user
    puts session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
