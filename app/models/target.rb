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


  # resultが投稿されたか調べる。
  def achievement_exists?(target, current_user)
    result = Result.find_by(target_id: target.id)
    # targetに紐づくresultはあるか
    if result.present?
      # 対象のresultは自分が投稿したものか
      if result.user.id == current_user
        # 自分のresultである
        return "my_result"
      else
        # 誰かのresultである
        return "someones_result"
      end
    else
      # 紐づくresultが未投稿
      if target.user_id == current_user
        # 自分のtargetであり、result未投稿
        return "my_target_yet_result"
      else
        # 誰かのtargetであり、result未投稿
        return "someones_target_yet_result"
      end
    end
  end

  # 対象のリザルトが投稿されていて、かつメモが空欄でないか。でなければfalseを返す
  def result_memo_exists?(target)
    Result.where.not(result_memo: nil || "").find_by(target_id: target.id).present?
  end
end
