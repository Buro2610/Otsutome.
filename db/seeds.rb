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


# preference_levelsの初期データを追加
preference_level_names = ["可能", "恐らく可","まだ不明", "多分不可", "絶対不可"]
preference_level_names.each do |name|
  PreferenceLevel.create!(name: name)
end

# time_slotsの初期データを追加
time_slot_definitions = [
  {name: "朝", start_time: "06:00", end_time: "10:00"},
  {name: "昼", start_time: "10:00", end_time: "14:00"},
  {name: "夕", start_time: "14:00", end_time: "19:00"},
  {name: "夜", start_time: "19:00", end_time: "24:00"}
]
time_slot_definitions.each do |definition|
  TimeSlot.create!(name: definition[:name], start_time: definition[:start_time], end_time: definition[:end_time])
end



