class MessagesController < ApplicationController
  before_action :add_messages

  def new
    @message = Message.new
  end

  def create
    @message = Message.new allowed_params
    @message.date_time = Time.now
    @message.user_id = current_user.id

    if @message.save
      flash[:notice] = I18n.t('messages.success.create')
      redirect_to new_message_path
    else
      render action: :new
    end
  end

  private

    def add_messages
      followings = current_user.followings.map{ |x| x.following_id }
      followings.push current_user.id
      @messages = Message.where(:user_id => followings).order('date_time DESC').to_a
    end

    def allowed_params
      params.require(:message).permit(
        :text
      )
    end
end