class User < ActiveRecord::Base
  include BCrypt

  validates :email, {presence: true, uniqueness: true}
  validates :pw_hash, presence: true
  validates :email, format: {with: /\S+@{1}\S+[.]\D{2,}/, message: 'is not a valid email address'}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.pw_hash == password
  end

end
