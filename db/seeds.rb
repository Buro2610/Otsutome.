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
  #ランダムな開始時間を作成
  datetime_from = DateTime.parse('2023-05-01 00:00:00')
  datetime_to = DateTime.parse('2023-06-30 00:00:00')
  random_time = rand(datetime_from..datetime_to)
  users.each { |user| user.shifts.create!( start_time: random_time, end_time: 1.hour.ago(random_time) , otsutome_title: random) }
end