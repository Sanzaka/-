class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  has_many :group_members, dependent: :destroy
  has_many :entry, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :group_messages, dependent: :destroy

  # 検索機能、名前が一致している部分があるuserを返す
  def self.looks(word)
    @user = User.where("name LIKE?","%#{word}%")
  end
end
