class Article < ApplicationRecord
  #validations
  validates :title, presence: true
  validates :body, presence: true, length: {minimum:10, to_short:"minimum is %{count} characters"}
  validates :author_id, presence: true
  validates :published, inclusion: [true, false]

  #association
  belongs_to :author # An article has one author hence it belongs to a single author

  #callback
  before_save ->{ # if the author is not a premium user, then he cannot publish more than five articles
    author=Author.find(self.author_id)
    if !author.premium_user # checking whether author is a premium user or not.
      articles=Article.find_by(author_id: author.id, published: true)
      if(articles.attributes.length>=5)
        self.published=false # setting the published attribute to false forcefully because author is not a premium user
        puts "article saved but published set to false as author is not a premium user"
      end
    end
  }
end
