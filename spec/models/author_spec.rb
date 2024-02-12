require 'rails_helper'

RSpec.describe Author, type: :model do
  before do
    @author=Author.new({
      name:"abc",
      email:"abc@mail.com",
      premium_user: true
    })
  end
  it "is valid" do
    expect(@author).to be_valid
  end
  it "is not valid, because name is nil" do
    @author.name=nil
    expect(@author).to_not be_valid
    expect(@author.errors[:name]).to include('author name not present')
  end
  it "is not valid, because the name length exceeds the limit 50" do
    @author.name='a'*51
    expect(@author).to_not be_valid
    expect(@author.errors[:name]).to include('maximum allowed length is 50 characters')
  end
  it "is not valid, because email is nil" do
    @author.email=nil
    expect(@author).to_not be_valid
    expect(@author.errors[:email]).to include('author email not present')
  end
  it "is not valid, because email length exceeds the limit 255" do
    @author.email=('a'*255)+'@mail.com'
    expect(@author).to_not be_valid
    expect(@author.errors[:email]).to include('maximum allowed length is 255 characters')
  end
  it "is not valid, because email used is not unique" do
    Author.create({
      name:"abc",
      email:"abc@mail.com",
      premium_user: true
    })
    @author.email='abc@mail.com'
    expect(@author).to_not be_valid
    expect(@author.errors[:email]).to include('User already registered use a different email')
  end
  it "is not valid, because premium_user is nil" do
    @author.premium_user=nil
    expect(@author).to_not be_valid
  end
  it "is valid with falsy value like false" do
    @author.premium_user=false
    expect(@author).to be_valid
  end
end
