require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @author=build_stubbed(:author)
    @article=build(:article, author: @author)
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
  it "is not valid because free not present" do
    @article.free=nil
    expect(@article).not_to be_valid
  end
  it "belongs to association check" do
    @article.author_id=123
    expect(@article).not_to be_valid
  end

  describe "#logic" do
    context "When author is a premium user and has published five articles" do
      let(:author) {create(:author,premium_user:true)}
      before do
        create_list(:article,5,author:author)
      end
      it "can publish more articles" do
        article=create(:article,author: author)
        expect(article.published).to be_truthy
      end
    end
    context "When author is not a premium user and have published 5 articles" do
      let(:author) {create(:author,premium_user:false)}
      before do
        create_list(:article,5,author:author)
      end
      it "can not publish another article but can create an article" do
        article=create(:article,author: author, published:true)
        expect(article.published).to be_falsy
      end
    end
  end
end
