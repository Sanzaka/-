class Group < ApplicationRecord
  attachment :image
  enum group_type: {"work_group": 0, "friend_group": 1}
end
