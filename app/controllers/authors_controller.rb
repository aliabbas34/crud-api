class AuthorsController < ApplicationController
  def index
    wantPremiumUsers=params[:premium_user]
    if wantPremiumUsers
      premiumAuthors=Author.where(premium_user:true)
      render json: premiumAuthors, status: 200
    else
    authors=Author.all
    render json: authors, status: 200
    end
  end

  def show
    begin
      author=Author.find_by(email: params[:email]) #finding author by email(PR change)
      if author
        render json: author, status: 200
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
        render json: author, status: 200
      end
    rescue StandardError=>e
      render json:{
        error:e
      }
    end
  end
  def search
    query=params[:query]
    authors=Author.where("email LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%")
    render json: authors, status: 200
  end
  private
    def author_params
      params.require(:author).permit(:name, :email, :premium_user)
    end
end
