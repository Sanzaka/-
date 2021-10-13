class Group < ApplicationRecord
  attachment :image
  enum group_type: {"work_group": 0, "friend_group": 1}
  validates :name, presence: true
  validates :group_type, presence: true

  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :entries, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :group_messages, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :stamps, dependent: :destroy



  def user_exists?(user, group)
    group_members.where(user_id: user.id, group_id: group.id).present?
  end

  # 検索機能、名前が一致している部分があるgroupを返す
  def self.looks(word)
    @user = Group.where("name LIKE?","%#{word}%")
  end

  def entry_exists?(user)
    self.entries.find_by(group_id: self.id, user_id: user.id)
  end


  # users/quick_formにて使用
  def today_my_target_exists?(user)
    self.targets.find_by(user_id: user, created_at: Time.zone.now.all_day).present?
  end

  def today_my_target(user)
    self.targets.find_by(user_id: user, created_at: Time.zone.now.all_day)
  end

  def today_my_result_exists?(user)
    self.results.find_by(user_id: user, created_at: Time.zone.now.all_day).present?
  end

  def today_my_result(user)
    self.results.find_by(user_id: user, created_at: Time.zone.now.all_day)
  end

end
