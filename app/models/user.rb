class User < ApplicationRecord
  has_secure_password
  has_many :tweets

  validates :username, length: { in: 2..10 }
  validates :username, uniqueness: true
  validates :password, length: { minimum: 4 }
end