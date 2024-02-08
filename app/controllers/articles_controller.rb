class ArticlesController < ApplicationController

  before_action :dummyLogForBeforeAction

  def index
    articles=Article.joins(:author).select('articles.*, authors.name AS author_name') #implementd joins
    render json: articles.as_json, status: 200
  end

  def show
    begin
      article=Article.find(params[:id])
      if article
        render json: article.as_json, status: 200
      end
    rescue StandardError => e
      render json: {
        error:e
      }
    end
  end

  def create
    begin
      author_email=params[:author_email]
      author_id=Author.where(email: author_email).pluck(:id).first
      if !author_id
        render json:{
          error: {message: "author not found use another email address"}
        }
      end
      article_body={
        title: params[:title],
        body: params[:body],
        author_id: author_id,
        published: params[:published]
      }
      article=Article.new(article_body)
      if article.save
        puts 'check'
        render json: article.as_json, status: 200
      end
    rescue StandardError => e
      render json: {
        error:e
      }
    end
  end

  def update
    begin
      article=Article.find(params[:id])
      if article
        author_email=params[:author_email]
        author_id=Author.where(email: author_email).pluck(:id).first
        if !author_id
          render json:{
            error: {message: "author not found use another email address"}
          }
        end
        article.update(title:params[:title],body:params[:body],author_id:author_id,published:params[:published])
        render json: "Article updated successfully"
      end
    rescue StandardError => e
      render json:{
        error:e
      }
    end
  end

  def destroy
    begin
      article=Article.find(params[:id])
      if article
        article.destroy
        render json:"Article deleted successfully"
      end
    rescue StandardError => e
      render json:{
        error:e
      }
    end
  end
  private
    def dummyLogForBeforeAction
      puts "Hello, befor action! from article controller."
    end
end
