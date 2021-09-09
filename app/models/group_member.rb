class GroupMember < ApplicationRecord

  enum operation_right: ["閲覧のみ可能": 0, "編集可能": 1]

  belongs_to :user
  belongs_to :group
end
