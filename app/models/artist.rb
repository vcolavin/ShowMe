class Artist < ActiveRecord::Base
  has_many :followings
  has_many :users, through: :followings

  has_many :artist_events
  has_many :events, through: :artist_events

  validate :name, {presence: true, uniqueness: true}

  # TODO: add validation that checks if the artist exists.
  # That would actually be pretty inefficient but I'm not sure how else it would be done.
  # Maybe only make the API call if the artist doesn't already exist in the DB
  # Well yeah.

  def get_upcoming_events
    # will return a list of upcoming events
  end
end
