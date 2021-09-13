class TargetsController < ApplicationController

  def create
    target = Target.new(target_params)
    target.save!
    flash[:notice] = "今日の目標を登録しました！"
    redirect_to request.referer
  end

  def edit
    @group = Group.find(params[:group_id])
    @target = Target.find(params[:id])
  end

  def update
    target = Target.find(params[:id])
    target.update(target_params)
    flash[:notice] = "目標を変更しました！"
    redirect_to group_path(params[:group_id])
  end

  def destroy
    target = Target.find(params[:id])
    target.destroy
    flash[:notice] = "今日の目標を削除しました！"
    redirect_to group_path(params[:group_id])
  end


  private

  def target_params
    params.require(:target).permit(:user_id, :group_id, :target_content)
  end
end
