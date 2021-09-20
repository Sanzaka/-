class Result < ApplicationRecord

  validates :target_id, presence: true
  validates :achievement, presence: {}

  belongs_to :target

end
