class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 80, minimum: 9 } , 
            uniqueness: { case_sensitive: false } , format: { with: VALID_EMAIL_REGEX }  
  validates :password, presence: true, length: { maximum: 30, minimum: 6 } , on: :create 

  has_many :articles
  has_many :opinions
  has_many :comments
end
