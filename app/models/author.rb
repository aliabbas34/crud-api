class Author < ApplicationRecord
  #association
  has_many :articles # An author can have many articles.

  #validations
  validates :name, presence: true, length:{maximum:50, to_long:"maximum allowed length is %{count} characters"}#Added length validation and custom message(PR chagne)
  validates :email, presence: true, length: {maximum: 255, to_long:"maximum allowed length is %{count} characters"}, uniqueness: {message:"User already registered use a different email"}#added custom message for uniqueness failure.
  validates :premium_user, inclusion: [true, false]
end
