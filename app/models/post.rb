class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id  # 1:M Association
end