class Event << ActiveRecord::Base
  has_many :artist_events
  has_many :artists, through: :artist_events
end
