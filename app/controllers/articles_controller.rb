class ArticlesController < ApplicationController
  def index
    articles=Article.joins(:author).select('articles.*, authors.name AS author_name') #implementd joins
    render json: articles, status: 200
  end

  def show
    begin
      article=Article.find(params[:id])
      puts (article.attributes)
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
      author_id: article_params[:author_id],
      published: article_params[:published]
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
        article.update(title:params[:title],body:params[:body],author_id:params[:author_id],published:params[:published])
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
        :author_id,
        :published
      ])
    end
end
