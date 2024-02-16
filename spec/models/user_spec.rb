require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user=build(:user)
    expect(user).to be_valid
  end
  it "is not valid if name is nil" do
    user=build(:user,name:nil)
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("user name not present")
  end
  it "is not valid because name length is less than 3" do
    user=build(:user,name:'aa')
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("length should be greater than or equal to 3")
  end
  it "is not valid if email is nil" do
    user=build(:user,email:nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("user email not present")
  end
  it "is not valid because email length is not between 10 to 255" do
    user=build(:user,email:'aa')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("email length should be between 10 to 255 characters")
    user.email=('a'*255)+'@mail.com'
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("email length should be between 10 to 255 characters")
  end
  it "is not valid because the email is already used" do
    user_a=create(:user,email:"abc@mail.com")
    user_b=build(:user,email:"abc@mail.com")
    expect(user_b).not_to be_valid
    expect(user_b.errors[:email]).to include("user already registered use a different email")
  end
  it "is not valid if paid_user is nil" do
    user=build(:user,paid_user:nil)
    expect(user).not_to be_valid
  end
end
