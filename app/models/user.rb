class User < ApplicationRecord
  has_secure_password

  has_many :buckets, foreign_key: :user_id

  validates_presence_of :name, :email, :password_digest
end
