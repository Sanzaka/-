class Group < ApplicationRecord
  attachment :image
  enum group_type: {"work_group": 0, "friend_group": 1}
  validates :name, presence: true
  validates :group_type, presence: true


  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :entry, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :group_messages, dependent: :destroy

  def user_exists?(user, group)
    GroupMember.find_by(user_id: user.id, group_id: group.id).present?
  end

  # 検索機能、名前が一致している部分があるgroupを返す
  def self.looks(word)
    @user = Group.where("name LIKE?","%#{word}%")
  end
end
