class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:edit]

  # indexで、グループの操作権限がない場合の処理(operation_right = 0の場合)
  def ensure_current_user
    unless GroupMember.find_by(user_id: current_user.id, group_id: params[:group_id], operation_right: 1).present?
      flash[:alert] = "閲覧権限がありません！"
      redirect_to user_path(current_user)
    end
  end

  def index
    @groups = Group.all
  end

  def show
    # 共通するインスタンス変数
    @group = Group.find(params[:id])
    @my_group_status = @group.group_members.find_by(group_id: @group, user_id: current_user.id)
    @entry = Entry.new
    @direct_join = GroupMember.new

    # workグループ
    @target = Target.new
    @result = Result.new
    @today_targets = @group.targets.where(created_at: Time.zone.now.all_day)
    @today_my_target = @today_targets.where(user_id: current_user.id).count

    # グラフ部分
    @results = @group.results.where(created_at: Time.zone.now.all_day).order(:achievement).last(7)


    # friendグループ
    @message = GroupMessage.new
    @messages = GroupMessage.where(group_id: @group.id).order(id: "desc")
    @stamp = Stamp.new
  end

  def new
    @group = Group.new
    @group_member = GroupMember.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      # グループ作成者をグループメンバーに含める処理
      @direct_join = GroupMember.new(group_member_params)
      @direct_join.user_id = current_user.id
      @direct_join.group_id = @group.id
      @direct_join.operation_right = 1
      @direct_join.save
      flash[:notice] = "グループを作成しました！"
      redirect_to group_path(@group.id)
    else
      flash.now[:alert] = "必要な情報を入力してください！"
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      flash.now[:alert] = "情報の変更に失敗しました！"
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループの削除が完了しました！"
    redirect_to user_path(current_user.id)
  end

  def my_group
    @my_groups = current_user.groups
  end


  private

  def group_params
    params.require(:group).permit(:name, :intro, :image, :group_type, :direct_join)
  end

  def group_member_params
    params.permit(:user_id, :group_id, :operation_right)
  end

end
