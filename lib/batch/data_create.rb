class Batch::DataCreate

  def self.target_create

    # target_contentの中身。sampleメソッドを用いてランダムに選出されるように
    contents = [
      "とりあえず頑張る！", "全力で頑張る！", "ケアレスミスをしないように集中する", "昨日学んだことを生かしたい！",
      "明日休みだから今日中に片づける！", "昨日と同じミスをしないように！", "頑張りすぎてばてないように",
      "誰の手も借りずに、今日の業務を片付ける", "がんばらない！", "早めに仕事を片付けて、カフェに行く！",
      "課題をすべて片付ける", "元気いっぱい頑張る！", "ミーティング中に寝ない", "笑顔いっぱいの接客！",
      "釣銭を渡し間違えない", "睡眠不足。仕事中集中する", "全力で仕事に取り組む", "昨日の自分より今日の自分！頑張る！"
    ]

    # user_id1はゲストユーザーなので、作成しないように処理
    2.upto(5) do |user|
      Target.create!(
        user_id: user,
        group_id: 1,
        target_content: contents.sample
      )
    end
  end

  def self.result_create

    memos = [
      "完璧かも？", "今日は自分をほめたい！", "目標通り達成できた！", "今日は調子が良かった", "とりくみを褒められた！", "今日はいい点数かも！",
      "明日もこの調子で頑張りたい！", "とても集中できた。", "毎日これくらい達成したい", "自分へのご褒美が必要",
      "明日はもっと頑張りたい", "すこし躓いた箇所があった。", "店長にミスを注意されてしまった" , "もう少し頑張れたかもしれない",
      "気ままにがんばりたい", "みんながうらやましい", "そんな日もある", "失敗したかも。。。", "遅刻してしまった。。。",
      "あしたがあるさ", "居眠りしてしまった", "一日集中できなかった", "今日の仕事が片付かなかった", "クレームが出てしまった",
      "ご褒美抜きにしたいと思います"
    ]

    2.upto(5) do |user|
      target = Target.find_by(created_at: Time.zone.now.all_day, user_id: user.to_i)
      Result.create!(
        target_id: target.id,
        achievement: rand(100),
        result_memo: memos.sample,
        group_id: 1,
        user_id: user
      )
    end
  end

end