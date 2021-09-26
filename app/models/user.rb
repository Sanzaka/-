class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :intro, length: { maximum: 50 }


  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_many :entry, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :group_messages, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :stamps, dependent: :destroy


  # 検索機能、名前が一致している部分があるuserを返す
  def self.looks(word)
    @user = User.where("name LIKE?","%#{word}%")
  end
end
