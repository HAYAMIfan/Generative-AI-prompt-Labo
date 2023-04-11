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
      password_confirmation: "1234admin",
      is_admin: true
    },
    {
      email: 'test1@test.com',
      name: 'テスト太郎',
      password: "1test1",
      password_confirmation: "1test1"
    },
    {
      email: 'test2@test.com',
      name: 'テスト次郎',
      password: "2test2",
      password_confirmation: "2test2"
    },
    {
      email: 'arashi@test.com',
      name: '荒らし',
      password: "typhoon",
      password_confirmation: "typhoon"
    }
  ]
)
