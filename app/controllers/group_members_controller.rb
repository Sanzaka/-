class GroupMembersController < ApplicationController
  before_action :authenticate_user!

  def create
    # 加入申請が承諾された場合の処理
    @group_member = GroupMember.new(group_member_params)
    @group_member.group_id = params[:group_id]
    @group_member.save

    # 加入申請が残らないように破棄
    entry = Entry.find_by(user_id: @group_member.user_id, group_id: params[:group_id])
    entry.destroy
    flash[:notice] = "メンバーを追加しました！"
    redirect_to group_path(params[:group_id])

  end

  def destroy
    @group_member = GroupMember.find_by(user_id: params[:id], group_id: params[:group_id])
    @group_member.destroy
    group = Group.find(params[:group_id])
    # 退会処理でグループメンバーが０人になったら、グループ削除
    if group.group_members.count == 0
      group.destroy
    end
    flash[:notice] = "グループの退会に成功しました！"
    redirect_to user_path(current_user.id)

  end

  def index
    @group_members = GroupMember.where(group_id: params[:group_id])
  end

  def direct
    # グループへの加入申請が必要ない場合の処理
    @direct_join = GroupMember.new(group_member_params)
    @direct_join.user_id = current_user.id
    @direct_join.group_id = params[:group_id]
    @direct_join.save!
    flash[:notice] = "グループに加わりました！"
    redirect_to group_path(params[:group_id])
  end

  private

  def group_member_params
    params.permit(:user_id, :group_id, :operation_right)
  end

end
