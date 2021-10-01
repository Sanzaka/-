class GroupMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    group_message = GroupMessage.new(group_message_params)
    group_message.user_id = current_user.id
    group_message.group_id = params[:group_id]
    if group_message.save
      flash[:notice] = "メッセージを投稿しました！"
      redirect_to request.referer
    else
      flash[:alert] = "メッセージを入力してください！"
      redirect_to request.referer
    end
  end

  def destroy
    group_message = GroupMessage.find(params[:id])
    group_message.destroy
    flash[:notice] = "メッセージを削除しました！"
    redirect_to request.referer
  end

  private
  def group_message_params
    params.require(:group_message).permit(:user_id, :group_id, :message)
  end
end
