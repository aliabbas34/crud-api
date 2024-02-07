require 'rails_helper'

RSpec.describe Author, type: :model do
  it "is valid" do
    author=Author.new({
      name:"abc",
      email:"abc@mail.com",
      premium_user: true
    })
    expect(author).to be_valid
  end
  it "is not valid, because name is nil" do
    author=Author.new({
      email:"abc@mail.com",
      premium_user:true
    })
    expect(author).to_not be_valid
  end
  it "is not valid, because the name length exceeds the limit 50" do
    author=Author.new({
      name:"abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijx",
      email:"abc@mail.com",
      premium_user:true
    })
    expect(author).to_not be_valid
  end
  it "is not valid, because email is nil" do
    author=Author.new({
      name:"abc",
      premium_user:true
    })
    expect(author).to_not be_valid
  end
  it "is not valid, because email length exceeds the limit 255" do
    author=Author.new({
      name:"abc",
      email:"abcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyz@mail.com",
      premium_user: true
    })
    expect(author).to_not be_valid
  end
  it "is not valid, because email used is not unique" do
    Author.create({
      name:"abc",
      email:"check@mail.com",
      premium_user: true
    })
    author=Author.new({
      name:"abc",
      email:"check@mail.com",
      premium_user: true
    })
    expect(author).to_not be_valid
  end
  it "is not valid, because premium_user is nil" do
    author=Author.new({
      name:"abc",
      email:"abc@mail.com",
    })
    expect(author).to_not be_valid
  end
  it "is valid with falsy value like false" do
    author=Author.new({
      name:"abc",
      email:"abc@mail.com",
      premium_user:false
    })
    expect(author).to be_valid
  end
end
