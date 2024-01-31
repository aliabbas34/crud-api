class AuthorsController < ApplicationController
  def index
    authors=Author.all
    render json: authors, status: 200
  end

  def show
    begin
      author=Author.find(params[:id])
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

  private
    def author_params
      params.require(:author).permit(:name, :email, :premium_user)
    end
end
