class GroupMessage < ApplicationRecord

 validates :user_id, presence: true
 validates :group_id, presence: true
 validates :message, presence: true

 belongs_to :user
 belongs_to :group

end
