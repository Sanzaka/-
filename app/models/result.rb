class Result < ApplicationRecord

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :target_id, presence: true
  validates :achievement, numericality: {less_than_or_equal_to: 100}


  belongs_to :target
  belongs_to :user
  belongs_to :group

  def self.chart_date
    order(created_at: :asc).pluck("created_at", "achievement").to_h
  end

end
