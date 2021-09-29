class EntriesController < ApplicationController
  before_action :authenticate_user!

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
