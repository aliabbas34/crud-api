class UsersController < ApplicationController
  def index
    user=User.all
    render json:user.as_json(only:[:id,:name,:email,:paid_user]), status:200
  end
  def create
    begin
      user=User.new({
        name:params[:name],
        email:params[:email],
        paid_user:params[:paid_user]
      })
      if user.save
        render json:user.as_json(only:[:name,:email,:paid_user]), status:200
      else
        render json:{
          message: user.errors.full_messages
        }
      end
    rescue StandardError=>e
      render json:{
        error:e
      }
    end
  end
  def show
    begin
      user_id=params[:id]
      user=User.find(user_id)
      articles=Article.eager_load(:author)
      articles=articles.where(free:true) if !user.paid_user
      render json:articles.as_json(include:[author:{only:[:name]}],only:[:id,:title,:body,:published,:free,]), status:200
    rescue StandardError=>e
      render json:{
        error:e
      }
    end
  end
end
