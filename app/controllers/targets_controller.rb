class TargetsController < ApplicationController
  before_action :authenticate_user!

  def create
    target = Target.new(target_params)
    target.user_id = current_user.id
    target.group_id = params[:group_id]
    if target.save
      flash[:notice] = "今日の目標を登録しました！"
      redirect_to request.referer
    else
      flash[:alert] = "情報を入力してください！"
      redirect_to request.referer
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @target = Target.find(params[:id])
  end

  def update
    @target = Target.find(params[:id])
    if @target.update(target_params)
      flash[:notice] = "目標を変更しました！"
      redirect_to group_path(params[:group_id])
    else
      flash.now[:alert] = "目標を入力してください！"
      render "edit"
    end
  end

  def destroy
    target = Target.find(params[:id])
    target.destroy
    flash[:notice] = "今日の目標を削除しました！"
    redirect_to group_path(params[:group_id])
  end

  def all_create
    user = current_user
    my_groups = user.group_members.all
    # 自分が所属するすべてのグループに投稿するための繰り返し処理
    my_groups.each do |my_group|
      target = Target.new(target_params)
      target.user_id = user.id
      target.group_id = my_group.group_id
      target.save
    end
    flash[:notice] = "今日の目標を投稿しました！"
    redirect_to request.referer
  end

  private

  def target_params
    params.require(:target).permit(:user_id, :group_id, :target_content)
  end
end
