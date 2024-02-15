require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    context "When per_page param is present in params" do
      it "returns 10 articles" do
        get :index, params:{per_page:10}
        expect(response).to have_http_status(200)
        expect(response.body).to include("id","title","body","published","author","name")
      end
    end
    context "when per_page param is not present in params" do
      it "returns message per_page param missing" do
        get :index
        expect(response.body).to include("per_page param missing")
      end
    end
  end
  describe "GET #show" do
    context "when article is present in db" do
      before do
        @author=create(:author)
        @article=create(:article, author_id:@author.id)
      end
      it "returns the article" do
        get :show, params:{id:@article.id}
        article={
          id:@article.id,
          title:@article.title,
          body:@article.body,
          published:@article.published,
          author:{
            name:@author.name
          }
        }
        expect(response.body).to include(article.to_json)
      end
    end
    context "when article is not present in db" do
      it "returns a message, Couldn't find article" do
        get :show, params:{id:8}
        expect(response.body).to include("Couldn't find Article with 'id'=8")
      end
    end
  end
  describe "POST #create" do
    context "when valid parameters are sent" do
      before do
        @author=create(:author,email:"test@mail.com")
      end
      it "creates an article" do
        valid_parameters={
          title:"test",
          body:"body of test article",
          published:true,
          author_email:"test@mail.com"
        }
        post :create,params:valid_parameters
        article={
          title:"test",
          body:"body of test article",
          author_id:@author.id,
          published:true
        }
        expect(response.body).to include(article.to_json)
      end
    end
    context "undefined email is sent" do
      it "says, author not found use another email address" do
        valid_parameters={
          title:"test",
          body:"body of test article",
          published:true,
          author_email:"undefined@mail.com"
        }
        post :create,params:valid_parameters
        expect(response.body).to include("author not found use another email address")
      end
    end
  end
  describe "PUT #update" do
    context "when valid parameters are sent" do
      before do
        @author=create(:author,email:"test@mail.com")
        @article=create(:article,author_id:@author.id)
      end
      it "updates the article" do
        valid_parameters={
          id:@article.id,
          title:"test",
          body:"body of test article",
          published:true,
          author_email:"test@mail.com"
        }
        put :update,params:valid_parameters
        expect(response.body).to include("Article updated successfully")
      end
    end
    context "undefined email is sent" do
      before do
        @article=create(:article)
      end
      it "says, author not found use another email address" do
        valid_parameters={
          id:@article.id,
          title:"test",
          body:"body of test article",
          published:true,
          author_email:"undefined@mail.com"
        }
        put :update,params:valid_parameters
        expect(response.body).to include("author not found use another email address")
      end
    end
  end
  describe "DELETE #destroy" do
    context "if article is present in db" do
      before do
        @article=create(:article)
      end
      it "deletes the article" do
        delete :destroy, params:{id:@article.id}
        expect(response.body).to include("Article deleted successfully")
      end
    end
    context "if article is not present in db" do
      it "says article not found" do
        delete :destroy, params:{id:9}
        expect(response.body).to include("Couldn't find Article with 'id'=9")
      end
    end
  end
end
