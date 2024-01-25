class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: {minimum:10, to_short:"minimum is %{count} characters"}
  validates :author, presence: true, uniqueness: true
end
