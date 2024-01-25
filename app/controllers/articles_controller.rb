class ArticlesController < ApplicationController
  def index
    articles=Article.all
    render json: articles, status: 200
  end

  def show
    begin
      article=Article.find(params[:id])
      if article
        render json: article, status: 200
      end
    rescue StandardError => e
      render json: {
        error:e
      }
    end
  end

  def create
    begin
      article=Article.new(
      title: article_params[:title],
      body: article_params[:body],
      author: article_params[:author]
      )
      if article.save
        render json: article, status: 200
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
        article.update(title:params[:title],body:params[:body],author:params[:author])
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
    def article_params
      params.require(:article).permit([
        :title,
        :body,
        :author
      ])
    end
end
