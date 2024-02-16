require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe "GET #index" do
    before do
      @author1=create(:author, name: "John Doe", email: "john@example.com", premium_user: true)
      @author2=create(:author, name: "Jane Smith", email: "jane@example.com", premium_user: false)
    end
    context "when no parameters are provided" do
      it "returns a list of all authors" do
        get :index
        expect(response).to have_http_status(200)
        author_a= @author1.to_json(only:[:id,:name,:email,:premium_user])
        author_b= @author2.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).to include(author_a, author_b)
      end
    end

    context "when premium_user parameter is true" do
      it "returns a list of premium authors" do
        get :index, params: { premium_user: true }
        expect(response).to have_http_status(200)
        author_a=@author1.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).to include(author_a)
        author_b= @author2.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).not_to include(author_b)
      end
    end

    context "when query parameter is provided" do
      it "returns a list of authors matching the query" do
        get :index, params: { query: "John" }
        expect(response).to have_http_status(200)
        author_a=@author1.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).to include(author_a)
        author_b= @author2.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).not_to include(author_b)
      end
    end

    context "when both premium_user and query parameters are provided" do
      it "returns a list of premium authors matching the query" do
        get :index, params: { premium_user: true, query: "John" }
        expect(response).to have_http_status(200)
        author_a=@author1.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).to include(author_a)
        author_b= @author2.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).not_to include(author_b)
      end
    end
  end

  describe "GET #show" do
    context "When author exist" do
      before do
        @author=create(:author,name:'john',email:'john@mail.com',premium_user:true)
      end
      it "returns an author if email is passed in params" do
        get :show, params:{email:'john@mail.com'}
        author_a=@author.to_json(only:[:id,:name,:email,:premium_user])
        expect(response.body).to include(author_a)
      end
      it "returns an error message if email is not passed in params" do
        get :show
        expect(response.body).to include("email not found in params")
      end
    end
    context "When author do not exist" do
      it "say's author not found if an non existing email is passed in params" do
        get :show, params:{email:"john@mail.com"}
        expect(response.body).to include("author not found")
      end
      it "say's email not found in params if email is not passed in params" do
        get :show
        expect(response.body).to include("email not found in params")
      end
    end
  end

  describe "POST #create" do
    context "when all attributes are passed in params" do
      it "creates an author" do
        post :create, params:{author:{name:"test",email:"test@mail.com",premium_user:true}}
        expect(response).to have_http_status(200)
        author={name:"test",email:"test@mail.com",premium_user:true}.to_json
        expect(response.body).to include(author)
      end
    end
  end

end
