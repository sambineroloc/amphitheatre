# Model representing the user
class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username, :email
end
