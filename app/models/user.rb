class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest, require: true
  validates_confirmation_of :password_digest

  has_secure_password
  has_secure_token :api_key

  def self.find_or_create(user)
    existing_user = find_by(email: user[:email])
    if existing_user == nil
      if user[:password_digest] == user[:password_confirmation]
        user = User.create(user)
      else
        user = User.new
      end
    else
      user = existing_user
    end
  end
end
