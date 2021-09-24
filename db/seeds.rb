# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ゲストログインで用いるユーザー
guestuser = User.new(:name => "ゲストユーザー", :email => "hogehoge@hoge.com", :password => "hugahuga", :is_email_receive => false)
guestuser.save!

# そのほか初期生成のユーザー
5.times do |i|
  if i == 0
    user = User.new(:name => "高橋祐樹", :email => "hogehoge#{i}@hoge.com", :password => "hugahuga#{i}", :is_email_receive => false)
    user.save!
  elsif i == 1
    user = User.new(:name => "すまいと", :email => "hogehoge#{i}@hoge.com", :password => "hugahuga#{i}", :is_email_receive => false)
    user.save!
  elsif i == 2
    user = User.new(:name => "ゆーだい", :email => "hogehoge#{i}@hoge.com", :password => "hugahuga#{i}", :is_email_receive => false)
    user.save!
  elsif i == 3
    user = User.new(:name => "綺羅星", :email => "hogehoge#{i}@hoge.com", :password => "hugahuga#{i}", :is_email_receive => false)
    user.save!
  elsif i == 4
    user = User.new(:name => "sanaka", :email => "hogehoge#{i}@hoge.com", :password => "hugahuga#{i}", :is_email_receive => false)
    user.save!
  end
end

# 初期生成のグループ
4.times do |i|
  if i == 0
    Group.create!(
      name: "みんなのワークグループ",
      intro: "みんなで目標を設定しよう！",
      group_type: "work_group",
      direct_join: true
    )
  elsif i == 1
    Group.create!(
      name: "みんなのフレンドグループ",
      intro: "楽しくお話ししませんか？",
      group_type: "friend_group",
      direct_join: true
    )
  elsif i == 2
    Group.create!(
      name: "自分に厳しく",
      intro: "大きな目標！厳しい採点！",
      group_type: "work_group",
      direct_join: true
    )
  elsif i == 3
    Group.create!(
      name: "お悩み事相談室",
      intro: "悩み事をここで打ち明けよう！それ以外でも自由に使ってください！",
      group_type: "friend_group",
      direct_join: true
    )

  end
end

# 初期生成のグループメンバー(IDの初期値を考慮しuptoを使用)
1.upto(5) do |user|
  1.upto(4) do |group|
    GroupMember.create!(
      user_id: user,
      group_id: group,
      operation_right: 0
    )
  end
end

#　初期生成のグループメッセージ(upto内でifが使えなかったため一つ一つ実装)

GroupMessage.create!(
  user_id: 2,
  group_id: 2,
  message: "今日は初仕事です！"
)
GroupMessage.create!(
  user_id: 3,
  group_id: 2,
  message: "今日は失敗してしまった。。。！"
)
GroupMessage.create!(
  user_id: 4,
  group_id: 2,
  message: "失敗する日もあります！頑張りましょう！！"
)
GroupMessage.create!(
  user_id: 5,
  group_id: 2,
  message: "今日から大きなプロジェクトが始まる。。。気合い入れて頑張ります"
)