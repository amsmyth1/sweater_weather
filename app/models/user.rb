class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true


  has_secure_password
  has_secure_token :api_key

  def self.find_or_create(user)
    existing_user = find_by(email: user[:email])
    if existing_user == nil
      user = User.create(user)
    else
      user = existing_user
    end
  end
end
