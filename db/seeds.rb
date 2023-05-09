# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
34.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
19.times do
  random = Faker::Lorem.sentence(word_count: 2)
  users.each { |user| user.shifts.create!( start_time: "2023-05-09 03:51:49", end_time: "2023-05-09 04:51:49", otsutome_title: random) }
end