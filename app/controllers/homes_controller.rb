class HomesController < ApplicationController

  def top
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: "guest1a2s3d@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.intro = "ゲストユーザーです。グループを建てたり、グループに参加したり、お楽しみください！"
    end
    sign_in user
    redirect_to user_path(current_user)
    flash[:notice] = "ゲストユーザーとしてログインしました！"
  end

end
