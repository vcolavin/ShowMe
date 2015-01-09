class Artists < ActiveRecord::Base
  has_many :user_artists
  has_many :users, through: :user_artists

  validate :name, {presence: true, uniqueness: true}
end
