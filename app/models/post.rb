class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id  # 1:M Association with User model
  has_many :comments, foreign_key: :post_id  # 1:M Associaiton with Comment model
end