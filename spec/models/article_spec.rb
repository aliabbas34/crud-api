require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @author=Author.create({
      name:'name',
      email:'email@mail.com',
      premium_user:true
    })
    @article=Article.new({
      title:"check",
      body:"article body check",
      author_id:@author.id,
      published:true
    })
  end
  it "is valid with valid attributes" do
    expect(@article).to be_valid
  end
  it "is not valid because title not present" do
    @article.title=nil
    expect(@article).not_to be_valid
    expect(@article.errors[:title]).to include('article title not present')
  end
  it "is not valid because the title length exceeds the limit 20" do
    @article.title='a'*21
    expect(@article).not_to be_valid
    expect(@article.errors[:title]).to include("maximum allowed length is 20 characters")
  end
  it "is not valid because body not present" do
    @article.body=nil
    expect(@article).not_to be_valid
    expect(@article.errors[:body]).to include('article body not present')
  end
  it "is not valid because the body length is less than the minimum limit 10" do
    @article.body='a'*9
    expect(@article).not_to be_valid
    expect(@article.errors[:body]).to include("minimum is 10 characters")
  end
  it "is not valid because author_id not present" do
    @article.author_id=nil
    expect(@article).not_to be_valid
    expect(@article.errors[:author_id]).to include("article's author's id not present")
  end
  it "is not valid because published not present" do
    @article.published=nil
    expect(@article).not_to be_valid
  end
  it "belongs to association check" do
    @article.author_id=2
    expect(@article).not_to be_valid
  end
end
