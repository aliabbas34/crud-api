class User < ApplicationRecord
  validates :name, presence:{message:'user name not present'}, length:{minimum:3, message:"length should be greater than or equal to 3"}
  validates :email, presence:{message:'user email not present'}, length:{minimum:10, maximum:255, message:'email length should be between 10 to 255 characters'}, uniqueness:{message:'user already registered use a different email'}
  validates :paid_user, inclusion:[true, false]
end
