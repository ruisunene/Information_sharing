# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'ruisunene'
)

Genre.create!(
   [
      {name: 'サンプル'},
      {name: 'テスト'},
      {name: '見本'}
   ]
)

users = User.create!(
  [
    {email: '1@1', name: 'サンプル太郎', password: 'password' },
    {email: '2@2', name: 'テスト花子', password: 'password' },
    {email: '3@3', name: '見本夏彦', password: 'password' }
  ]
)

Info.create!(
   [
   {title: 'サンプル', body: 'この投稿はサンプルです', user_id: 1, genre_id: 1},
   {title: 'テスト', body: 'この投稿はテストです', user_id: 2, genre_id: 2},
   {title: '見本', body: 'この投稿は見本です', user_id: 3, genre_id: 3}
   ]
)

Group.create!(
  [
    {name: 'サンプルグループ', introduction: 'このグループはサンプルです', owner_id: 1}
  ]
  )


