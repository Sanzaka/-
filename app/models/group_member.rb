class GroupMember < ApplicationRecord

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :operation_right, presence: true

  belongs_to :user
  belongs_to :group

end
