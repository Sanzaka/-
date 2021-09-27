class StampsController < ApplicationController

  def create
    @msg = GroupMessage.find(params[:message_id])
    @group = Group.find(params[:group_id])
    @stamp = Stamp.new(stamp_params)
    @stamp.user_id = current_user.id
    @stamp.group_id = params[:group_id]
    @stamp.group_message_id = params[:message_id]
    @stamp.save!
  end

  def destroy
    @msg = GroupMessage.find(params[:message_id])
    @group = Group.find(params[:group_id])
    @stamp = Stamp.find_by(user_id: current_user, group_id: params[:group_id], group_message_id: params[:id], choose_stamp: params[:choose_stamp])
    @stamp.destroy
  end

  private
  def stamp_params
    params.require(:stamp).permit(:user_id, :group_id, :group_message_id, :choose_stamp)
  end
end