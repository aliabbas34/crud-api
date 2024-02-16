FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString@mail.com" }
    paid_user { false }
  end
end
