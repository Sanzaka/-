class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:index]

  # indexで、グループの操作権限がない場合の処理(operation_right = 0の場合)
  def ensure_current_user
    unless GroupMember.find_by(user_id: current_user.id, group_id: params[:group_id], operation_right: 1).present?
      flash[:alert] = "閲覧権限がありません！"
      redirect_to user_path(current_user)
    end
  end


  def create
    # 送信者のid、ページのグループidを取得し、加入申請として保存
    entry = Entry.new(entry_params)
    entry.user_id = current_user.id
    entry.group_id = params[:group_id]
    entry.save
    flash[:notice] = "加入申請を送りました！"
    redirect_to request.referer
  end

  def destroy
    # 申請却下、取り下げの場合はこちらを実行
    @entry = Entry.find_by(group_id: params[:group_id], id: params[:id])
    @entry.destroy
    redirect_to request.referer
  end

  def index
    @entries = Entry.where(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
    @group_member = GroupMember.new
  end

  private

  def entry_params
    params.permit(:user_id, :group_id)
  end

end
