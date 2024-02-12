class AuthorsController < ApplicationController

  before_action :dummyLogForBeforeAction 

  def index
    wantPremiumUsers=params[:premium_user]
    query=params[:query]
    authors=Author.all
    authors=authors.where(premium_user:true) if wantPremiumUsers
    authors=authors.where("email LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%") if(query)
    render json: authors.as_json(only: [:id,:name,:email,:premium_user]), status: 200
  end

  def show
    begin
      author=Author.find_by(email: params[:email])
      if author
        render json: author.as_json(only: [:id, :name,:email,:premium_user]), status: 200
      else
        render json:{
          error: {message: "author not found"}
        }
      end
    rescue StandardError => e
      render json:{
        error:e
      }
    end
  end

  def create
    begin
      author=Author.new(
        name: author_params[:name],
        email: author_params[:email],
        premium_user: author_params[:premium_user]
      )
      if author.save
        render json: author.as_json, status: 200
      else
        render json:{
          error:{message: author.errors.full_messages}
        }
      end
    rescue StandardError=>e
      render json:{
        error:e
      }
    end
  end

  private
    def author_params
      params.require(:author).permit(:name, :email, :premium_user)
    end
    def dummyLogForBeforeAction
      puts "Hello, before action!"
    end
end
