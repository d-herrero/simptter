class UsersController < ApplicationController
  before_action :find_user, only: %w(show api_get_info api_get_messages api_get_followers api_get_followings)

  def index
    @users = User.where.not(id: current_user.id).order('id DESC').to_a
    @followings = current_user.followings.map{ |x| x.following_id }
  end

  def show
  end

  def follow
    unless params[:id] == current_user.id.to_s
      UserRelation.create({
        user_id: current_user.id,
        following_id: params[:id]
      })
    end

    redirect_to users_path
  end

  def unfollow
    UserRelation.where(user_id: current_user.id, following_id: params[:id]).first.destroy

    redirect_to users_path
  end

  def api_get_info
    api_respond @user
  end

  def api_get_messages
    api_respond @user.messages
  end

  def api_get_followers
    api_respond @user.followers.map{ |x| x.user }
  end

  def api_get_followings
    api_respond @user.followings.map{ |x| x.following }
  end

  private

    def find_user
      @user = User.find params[:id]
    end
end