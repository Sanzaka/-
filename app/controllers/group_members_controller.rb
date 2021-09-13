class GroupMembersController < ApplicationController

  def create
    # 加入申請が承諾された場合の処理
    @group_member = GroupMember.new(group_member_params)
    @group_member.user_id = current_user.id
    @group_member.group_id = params[:group_id]
    @group_member.operation_right = 0
    if @group_member.save
      # 加入申請が残らないように破棄
      entry = Entry.find_by(user_id: current_user.id, group_id: params[:group_id])
      entry.destroy
      flash[:notice] = "メンバーを追加しました！"
      redirect_to group_path(params[:group_id])
    else
      flash[:alert] = "メンバーの登録に失敗しました！"
      redirect_to
    end

  end

  def destroy
    @group_member = GroupMember.find_by(user_id: params[:id], group_id: params[:group_id])
    @group_member.destroy
    flash[:notice] = "グループの退会に成功しました！"
    redirect_to user_path(current_user.id)

  end

  def index
  end

  private

  def group_member_params
    params.permit(:user_id, :group_id, :operation_right)
  end

end
