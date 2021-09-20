class ResultsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = Result.new(result_params)
    if result.save
      flash[:notice] = "取組結果を保存しました！"
      redirect_to group_path(result.target.group_id)
    else
      flash[:alert] = "情報を入力してください！"
      redirect_to group_path(result.target.group_id)
    end
  end

  def edit
    @target = Target.find(params[:target_id])
    @result = Result.find(params[:id])
  end

  def update
    @result = Result.find(params[:id])
    @target = Target.find(params[:target_id])
    if @result.update(result_params)
      flash[:notice] = "取組結果を変更しました！"
      redirect_to group_path(@target.group_id)
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
    params.require(:result).permit(:target_id, :achievement, :result_memo)
  end
end
