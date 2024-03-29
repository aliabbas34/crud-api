class ArticlesController < ApplicationController

  before_action :dummyLogForBeforeAction

  def index
    articles=Article.eager_load(:author).limit(params[:per_page])
    render json: articles.as_json(include: [author: {only:[:name]}], only:[:id,:title,:body,:published]), status: 200
  end

  def show
    begin
      article=Article.includes(:author).find(params[:id])
      if article
        render json: article.as_json(include: [author:{only:[:name]}], only:[:id,:title,:body,:published]), status: 200
      else
        render json:{
          error:{message: "article not found"}
        }
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
      author_id=Author.find_by(email: author_email)
      if !author_id
        render json:{
          error: {message: "author not found use another email address"}
        }
      else
        author_id=author_id.id
        article_body={
          title: params[:title],
          body: params[:body],
          author_id: author_id,
          published: params[:published]
        }
        article=Article.new(article_body)
        if article.save
          render json: article.as_json, status: 200
        else
          render json:{
            error:{message: article.errors.full_messages}
          }
        end
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
        author_id=Author.find_by(email: author_email)
        if !author_id
          render json:{
            error: {message: "author not found use another email address"}
          }
        else
          author_id=author_id.id
          if article.update(title:params[:title],body:params[:body],author_id:author_id,published:params[:published])
            render json: "Article updated successfully"
          else
            render json:{
              error:{ message: article.errors.full_messages}
            }
          end
        end
      else
        render json:{
          error:{message: "article not found"}
        }
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
        if article.destroy
          render json:"Article deleted successfully"
        else
          render json:{
            error:{message: article.errors.full_messages}
          }
        end
      else
        render json:{
          error: {message: "artilce not found"}
        }
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
