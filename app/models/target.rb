class Target < ApplicationRecord

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :target_content, presence: { message: ""}, length: {maximum: 100}

  belongs_to :user
  belongs_to :group
  has_one :result, dependent: :destroy

  def target_exists?
    self.where(user_id: current_user.id).present?
  end


  # resultが投稿されたか調べる。なければfalseを返す
  def achievement_by?(target)
    Result.find_by(target_id: target.id).present?
  end

  # 対象のリザルトが投稿されていて、かつメモが空欄でないか。でなければfalseを返す
  def result_memo_exists?(target)
    Result.where.not(result_memo: nil || "").find_by(target_id: target.id).present?
  end
end
