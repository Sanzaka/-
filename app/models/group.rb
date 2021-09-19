class Group < ApplicationRecord
  attachment :image
  enum group_type: {"work_group": 0, "friend_group": 1}

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :entry, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :group_messages, dependent: :destroy

  def user_exists?(user, group)
    GroupMember.find_by(user_id: user.id, group_id: group.id).present?
  end
end
