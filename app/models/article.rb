class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :opinions
  has_many :comments
end
