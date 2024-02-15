class Article < ApplicationRecord
  #validations
  validates :title, presence: {message:"article title not present"}, length: {maximum:20, message:"maximum allowed length is %{count} characters"}
  validates :body, presence: {message:"article body not present"}, length: {minimum:10, message:"minimum is %{count} characters"}
  validates :author_id, presence: {message:"article's author's id not present"}
  validates :published, inclusion: [true, false]
  validates :free, inclusion: [true, false]

  #association
  belongs_to :author # An article has one author hence it belongs to a single author

  #callback method
  def logic
     # if the author is not a premium user, then he cannot publish more than five articles
    author=Author.find(self.author_id)
    if !author.premium_user
      articles=Article.where(author_id: author.id, published: true)
      if(articles.count>=5)
        self.published=false # setting the published attribute to false forcefully because author is not a premium user
        puts "article saved but published set to false as author is not a premium user"
      end
    end
  end
  #callback
  before_save :logic
end
