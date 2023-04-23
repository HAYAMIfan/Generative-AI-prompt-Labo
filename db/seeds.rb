# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  [
    {
      email: 'admin@gmail.com',
      name: '管理人',
      password: "1234admin",
      is_admin: true
    },
    {
      email: 'test@test.com',
      name: '山田・テスト・太郎',
      password: "yamatesutaro",
    },
    {
      email: 'long@test.com',
      name: '長文テストアカウント・名前は20文字まで',
      password: "longtxt",
    },
    {
      email: 'arashi@test.com',
      name: '荒らし',
      password: "typhoon",
    }
  ]
)
10.times do |n|
  User.seed do |s|
    s.name = "テストアカウント#{n}"
    s.email = "aaa#{n}@gmail.com"
    s.password = "123456"
  end
end
