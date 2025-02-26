class Post < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :title, presence: true
  validates :description, presence: true
  
end
