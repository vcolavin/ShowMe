class ArtistEvent << ActiveRecord::Base
  has_many :events
  has_many :artists
end
