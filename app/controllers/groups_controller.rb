class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @group_member = GroupMember.new
    @group_members = GroupMember.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
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
    @group.update(group_params)
    redirect_to group_path(@group.id)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループの削除が完了しました！"
    redirect_to user_path(current_user.id)
  end

  def data
  end

  private

  def group_params
    params.require(:group).permit(:name, :intro, :image, :group_type)
  end

end
