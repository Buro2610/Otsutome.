# メインのサンプルユーザーを1人作成する
admin_user = User.create!(name:  "管理人1",
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


# 管理人のみ編集可能なカラムであるtask_name を設定
task_names = ["オーダー", "オーブン", "パスタ", "ウォッシュ", "ドリンク"]
task_names.each_with_index do |task_name, i|
  task = Task.create!(id: i + 1, name: task_name, user: admin_user)
end


# ユーザーの一部を対象にシフトを生成する
users = User.order(:created_at).take(6)
tasks = ["オーダー", "オーブン", "パスタ", "ウォッシュ", "ドリンク"]

19.times do
  users.each do |user|
    date_from = Date.parse('2023-05-01')
    date_to = Date.parse('2023-06-30')
    random_date = rand(date_from..date_to)

    hour_from = 0
    hour_to = 23
    random_hour_start = rand(hour_from..hour_to)
    random_hour_end = random_hour_start + 1

    random_start_time = DateTime.new(random_date.year, random_date.month, random_date.day, random_hour_start)
    random_end_time = DateTime.new(random_date.year, random_date.month, random_date.day, random_hour_end)

    random_task = tasks.sample
    user.shifts.create!(start_time: random_start_time, end_time: random_end_time, otsutome_title: random_task)
  end
end

