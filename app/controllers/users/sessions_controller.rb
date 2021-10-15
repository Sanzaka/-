# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # 退会後のユーザーはログインできないようにする
  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
        redirect_to new_user_session_path
      end
    end
  end

end
