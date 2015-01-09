class User < ActiveRecord::Base
  include BCrypt

  has_many :user_artists
  has_many :artists, through: :user_artists

  validates :email, {presence: true, uniqueness: true}
  validates :password_hash, presence: true
  validates :email, format: {with: /\S+@{1}\S+[.]\D{2,}/, message: 'is not a valid email address'}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    # puts new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    puts self.password
    puts password
    self.password == password
  end

end
