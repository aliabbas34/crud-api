class Author < ApplicationRecord
  #association
  has_many :articles # An author can have many articles.

  #validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :premium_user, inclusion: [true, false]
end
