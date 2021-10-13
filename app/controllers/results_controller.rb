class ResultsController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    target = group.targets.find_by(user_id: current_user.id, created_at: Time.zone.now.all_day)
    result = Result.new(result_params)
    result.target_id = target.id
    result.user_id = current_user.id
    result.group_id = group.id
    if result.save
      flash[:notice] = "取組結果を保存しました！"
      redirect_to request.referer
    else
      flash[:alert] = "情報を入力してください！"
      redirect_to request.referer
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @result = Result.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @result = Result.find(params[:id])
    if @result.update(result_params)
      flash[:notice] = "取組結果を変更しました！"
      redirect_to group_path(@group.id)
    else
      flash.now[:alert] = "情報を入力してください！"
      render "edit"
    end
  end

  def destroy
    result = Result.find(params[:id])
    result.destroy
    flash[:notice] = "取組結果を削除しました！"
    redirect_to group_path(params[:group_id])
  end

  private

  def result_params
    params.require(:result).permit(:target_id, :achievement, :result_memo, :user_id, :group_id)
  end
end
