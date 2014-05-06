class User < ActiveRecord::Base 
  has_many :posts, foreign_key: :user_id  # 1:M Associaton with User model
  has_many :comments, foreign_key: :user_id  # 1:M Association with Comment model
end