class GroupMessage < ApplicationRecord

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :message, presence: true

  belongs_to :user
  belongs_to :group
  has_many :stamps, dependent: :destroy

  def stamp1_exists?(user, message)
    Stamp.where(user_id: user, group_message_id: message, choose_stamp: 1).present?
  end

  def stamp2_exists?(user, message)
    Stamp.where(user_id: user, group_message_id: message, choose_stamp: 2).present?
  end

  def stamp3_exists?(user, message)
    Stamp.where(user_id: user, group_message_id: message, choose_stamp: 3).present?
  end

  def stamp_count1
    self.stamps.where(choose_stamp: 1)
  end

  def stamp_count2
    self.stamps.where(choose_stamp: 2)
  end

  def stamp_count3
    self.stamps.where(choose_stamp: 3)
  end

end
