class ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
    @user = User.find(current_user.id)
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      flash[:notice] = "お問合せありがとうございます！送信に成功しました！"
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "必要な情報を入力してください！"
      render "new"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
