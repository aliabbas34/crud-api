require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    context "when get request is sent to index controller" do
      before do
        @user1=create(:user,email:'abc@mail.com')
        @user2=create(:user,email:'def@mail.com')
        @user3=create(:user,email:'ghi@mail.com')
      end
      it "returns all users" do
        get :index
        user1=@user1.to_json(only:[:id,:name,:email,:paid_user])
        user2=@user2.to_json(only:[:id,:name,:email,:paid_user])
        user3=@user3.to_json(only:[:id,:name,:email,:paid_user])
        expect(response.body).to include(user1,user2,user3)
      end
    end
  end
  describe "POST #create" do
    context "when valid parameters are given" do
      it "creates the user" do
        valid_parameters={
          name:"abc",
          email:"abc@mail.com",
          paid_user:true
        }
        post :create, params:valid_parameters
        expect(response.body).to include(valid_parameters.to_json)
      end
    end
  end
  describe "GET #show" do
    context "when user is a paid user" do
      it "returns both, free and paid articles" do
        user=create(:user,paid_user:true)
        get :show, params:{id:user.id}
        articles=Article.all
        expect(JSON.parse(response.body).count).to eq(articles.count)
      end
    end
    context "when user is a guest user" do
      it "returns only free articles" do
        user=create(:user,paid_user:false)
        get :show, params:{id:user.id}
        articles=Article.all
        articles=articles.where(free:true)
        expect(JSON.parse(response.body).count).to eq(articles.count)
      end
    end
  end
end
