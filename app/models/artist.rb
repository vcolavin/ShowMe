class Artist < ActiveRecord::Base
  has_many :followings
  has_many :users, through: :followings

  validate :name, {presence: true, uniqueness: true}

  # TODO: add validation that checks if the artist exists.
  # That would actually be pretty inefficient but I'm not sure how else it would be done.
  # Maybe only make the API call if the artist doesn't already exist in the DB
  # Well yeah.
end
