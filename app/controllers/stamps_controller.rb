class StampsController < ApplicationController

  def create
    @stamp = Stamp.new(stamp_params)
    @stamp.user_id = current_user.id
    @stamp.group_id = params[:group_id]
    @stamp.group_message_id = params[:message_id]
    if @stamp.save!
      flash[:notice] = "スタンプを送信しました！"
      redirect_to group_path(params[:group_id])
    else
      flash[:alert] = "スタンプの送信に失敗しました！"
      redirect_to group_path(params[:group_id])
    end
  end

  def destroy
    @stamp = Stamp.find_by(user_id: current_user, group_id: params[:group_id], group_message_id: params[:id], choose_stamp: params[:choose_stamp])
    @stamp.destroy
    flash[:notice] = "スタンプを削除しました！"
    redirect_to group_path(params[:group_id])
  end

  private
  def stamp_params
    params.require(:stamp).permit(:user_id, :group_id, :group_message_id, :choose_stamp)
  end
end