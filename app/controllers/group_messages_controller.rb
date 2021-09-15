class GroupMessagesController < ApplicationController

  def create
    group_message = GroupMessage.new(group_message_params)
    if group_message.save
      flash[:notice] = "メッセージを投稿しました！"
      redirect_to request.referer
    else
      flash[:notice] = "メッセージを入力してください！"
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
