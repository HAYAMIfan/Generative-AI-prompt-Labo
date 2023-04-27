# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  [
    {
      email: 'admin@test.com',
      name: '管理人',
      password: "1234admin",
      is_admin: true,
    },
    {
      email: 'long@test.com',
      name: '長文テストアカウント名前は20文字まで',
      password: "longtxt",
    },
    {
      email: 'test@test.com',
      name: '山田・テスト・太郎',
      password: "yamatesutaro",
    },
    {
      email: 'arashi@test.com',
      name: '荒らし',
      password: "typhoon",
    }
  ]
)
user[0].icon.attach(io: File.open(Rails.root.join('app/assets/images/admin.png')),
                  filename: 'admin.png')
user[1].icon.attach(io: File.open(Rails.root.join('app/assets/images/入道雲.jpeg')),
                  filename: '入道雲.jpeg')
user[3].icon.attach(io: File.open(Rails.root.join('app/assets/images/arashi.png')),
                  filename: 'arashi.png')
20.times do |n|
  User.create! do |s|
    s.name = "水増し#{n+1}"
    s.email = "aaa#{n+1}@gmail.com"
    s.password = "123456"
  end
end

10.times do |n|
  Relationship.create! do |s|
    s.follower_id = 2
    s.followed_id = n+3
  end
end
10.times do |n|
  Relationship.create! do |s|
    s.follower_id = n+10
    s.followed_id = 2
  end
end

about = Post.create!(
  user_id: 1,
  title: "当サイトについて",
  content: "最近の生成AIの進歩はまさに日進月歩といった勢いで、このポートフォリオを製作している最中にも様々な変化がありました。<br>当サイトは主にChat GPT3.5とのやりとりから着想を経ており、どんな文章(=呪文、プロンプト)を入力すればChat GPTが答えやすいかを皆で追い求めることをテーマとしています。<br>そのために最低限必要な機能を考えた結果、Chat GPTとのやり取りをスクリーンショットとして添付して投稿し、いいね！で評価しあいコメントを残せるように設計しました。",
)
about.images.attach(io: File.open(Rails.root.join('app/assets/images/sample_image.png')),
                  filename: 'sample_image.png')
20.times do |n|
  Post.create!(user_id: 2, title: "水増し用投稿#{n+1}", content: "この投稿は水増し用の投稿です",)
end
post = Post.create!(
  [
    {
      user_id: 2,
      title: "投稿一覧画面において、タイトルは途中で省略されて表示されます\n投稿一覧画面において、タイトルは途中で省略されて表示されます",
      content: "長文テスト"*200,
    },
    {
      user_id: 4,
      title: "荒らしの仕業",
      content: "荒らしによる投稿　アカウント停止・復旧のテスト用",
    }
  ]
)
post[0].images.attach(io: File.open(Rails.root.join('app/assets/images/退会処理.png')),
                  filename: '退会処理.png')
post[1].images.attach(io: File.open(Rails.root.join('app/assets/images/shizensaigai_typhoon.png')),
                  filename: 'shizensaigai_typhoon.png')
