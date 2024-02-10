class Author < ApplicationRecord
  #association
  has_many :articles # An author can have many articles.

  #validations
  validates :name, presence: {message: "author name not present"}, length:{maximum:50, message:"maximum allowed length is %{count} characters"}#Added length validation and custom message(PR chagne)
  validates :email, presence: {message: "author email not present"}, length: {maximum: 255, message:"maximum allowed length is %{count} characters"}, uniqueness: {message:"User already registered use a different email"}#added custom message for uniqueness failure.
  validates :premium_user, inclusion: [true, false]
end
