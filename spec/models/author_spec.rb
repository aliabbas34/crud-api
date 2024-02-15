require 'rails_helper'

RSpec.describe Author, type: :model do

  it "is valid" do
    author=build(:author)
    expect(author).to be_valid
  end
  it "is not valid, because name is nil" do
    author=build(:author,name:nil)
    expect(author).to_not be_valid
    expect(author.errors[:name]).to include('author name not present')
  end
  it "is not valid, because the name length exceeds the limit 50" do
    author=build(:author,name:'a'*51)
    expect(author).to_not be_valid
    expect(author.errors[:name]).to include('maximum allowed length is 50 characters')
  end
  it "is not valid, because email is nil" do
    author=build(:author,email:nil)
    expect(author).to_not be_valid
    expect(author.errors[:email]).to include('author email not present')
  end
  it "is not valid, because email length exceeds the limit 255" do
    author=build(:author,email:('a'*255)+'@mail.com')
    expect(author).to_not be_valid
    expect(author.errors[:email]).to include('maximum allowed length is 255 characters')
  end
  it "is not valid, because email used is not unique" do
    author_a=create(:author)
    author_b=build(:author)
    expect(author_b).to_not be_valid
    expect(author_b.errors[:email]).to include('User already registered use a different email')
  end
  it "is not valid, because premium_user is nil" do
    author=build(:author,premium_user:nil)
    expect(author).to_not be_valid
  end
  it "is valid with falsy value like false" do
    author=build(:author,premium_user:false)
    expect(author).to be_valid
  end
end
