class UsersController < ApplicationController

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました！"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "必要な情報を入力してください！"
      render edit
    end
  end

  def show
    @user = User.find(current_user.id)
    @group_ranks = Group.find(GroupMember.group(:group_id).order("count(group_id) desc").limit(3).pluck(:group_id))
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :intro, :image, :is_email_receive)
  end
end
