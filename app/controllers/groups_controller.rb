class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:edit, :update]

  # indexで、グループの操作権限がない場合の処理(operation_right = 0の場合)
  def ensure_current_user
    unless GroupMember.find_by(user_id: current_user.id, group_id: params[:group_id], operation_right: 1).present?
      flash[:alert] = "閲覧権限がありません！"
      redirect_to user_path(current_user)
    end
  end

  def index
    @groups = Group.all.page(params[:page]).per(10)
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
    @today_targets = @group.targets.where(created_at: Time.zone.now.all_day).page(params[:page]).per(10)
    @today_my_target = @today_targets.where(user_id: current_user.id).count

    # グラフ部分(chart.js)
    graph_datas = @group.results.where(created_at: Time.zone.now.all_day).order(:achievement).last(7)
    # graph_datasの順で、下のラベルに名前を入力させるための処理
    graph_labels = []
    graph_datas.each do |g|
      user = User.find(g.user_id)
      graph_labels << user.name
    end
    # graph_labelsが6個以下の場合、配列の合計数が7個になるように処理
    empties = 7 - graph_labels.size
    if empties > 0
      empties.times do
        graph_labels << "no_data"
      end
    end
    # groups.coffeeに受け渡す部分
    gon.datas = graph_datas.pluck(:achievement)
    gon.labels = graph_labels

    # friendグループ
    @message = GroupMessage.new
    @messages = GroupMessage.where(group_id: @group.id).order(id: "desc").page(params[:page]).per(15)
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
    @my_groups = current_user.groups.page(params[:page]).per(10)
  end


  private

  def group_params
    params.require(:group).permit(:name, :intro, :image, :group_type, :direct_join)
  end

  def group_member_params
    params.permit(:user_id, :group_id, :operation_right)
  end

end
