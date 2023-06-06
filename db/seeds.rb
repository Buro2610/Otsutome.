# メインのサンプルユーザーを1人作成する
admin_user = User.create!(name:  "管理人1",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
8.times do |n|
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
task_names.each_with_index do |task_name, index|
  task = Task.create!(name: task_name, order: index, user: admin_user)
end


# ユーザーの一部を対象にシフトを生成する
users = User.order(:created_at).take(12)
tasks = ["オーダー", "オーブン", "パスタ", "ウォッシュ", "ドリンク"]

time_zone = ActiveSupport::TimeZone.new("Tokyo") # 追加

5.times do
  users.each do |user|
    date_from = Date.parse('2023-06-01')
    date_to = Date.parse('2023-06-30')
    random_date = rand(date_from..date_to)

    # そのユーザーがその日にすでにシフトを持っているか確認
    next if user.shifts.where('DATE(start_time) = :date', date: random_date).exists?

    hour_from = 7
    hour_to = 18 # 最大開始時間を18時に制限
    random_hour_start = rand(hour_from..hour_to)
    random_hour_end = random_hour_start + 5

    # タイムゾーンを明示的に指定してDateTimeオブジェクトを作成
    random_start_time = time_zone.local(random_date.year, random_date.month, random_date.day, random_hour_start)
    random_end_time = time_zone.local(random_date.year, random_date.month, random_date.day, random_hour_end)

    random_task = tasks.sample
    user.shifts.create!(start_time: random_start_time, end_time: random_end_time, otsutome_title: random_task)
  end
end


# colorの初期データを追加
colors = ["blue", "green", "yellow", "red", "gray", "#FF00FF", "#800080", "#FF4500", "#8B4513", "#4682B4", "#32CD32", "#008080"]
color_objects = colors.map do |color|
  Color.create!(name: color)
end

# preference_level_namesの初期データを追加
preference_level_names = ["可能", "多分可能", "多分不可", "不可","不明"]

# preference_levelsの初期データを追加
preference_level_names.each_with_index do |name, index|
  PreferenceLevel.create!(name: name, color_id: color_objects[index].id, order: index)
end


# time_slotsの初期データを追加
time_slot_definitions = [
  {name: "朝", start_time: "07:00", end_time: "10:00"},
  {name: "昼", start_time: "10:00", end_time: "14:00"},
  {name: "夕", start_time: "14:00", end_time: "18:00"},
  {name: "夜", start_time: "18:00", end_time: "22:00"}
]
time_zone = ActiveSupport::TimeZone.new("Tokyo")  # <- ここを追加
time_slot_definitions.each_with_index do |definition, index|
  TimeSlot.create!(
    name: definition[:name],
    start_time: time_zone.parse(definition[:start_time]),
    end_time: time_zone.parse(definition[:end_time]),
    order: index
  )
end




# admin以外のユーザーの今日から21日間の各日に対してランダムなshift_preferenceを生成する
non_admin_users = User.where.not(id: admin_user.id)
time_slots = TimeSlot.all  # <- ここを追加

(0..21).each do |n|
  current_date = Date.today + n.days
  current_time = current_date.to_time
  non_admin_users.each do |user|
    time_slots.each do |time_slot|
      start_time = current_time.change({ hour: time_slot.start_time.hour, min: time_slot.start_time.min })
      end_time = current_time.change({ hour: time_slot.end_time.hour, min: time_slot.end_time.min })
      preference_level_id = PreferenceLevel.ids.sample
      ShiftPreference.create!(user: user, start_time: start_time, end_time: end_time, time_slot: time_slot, preference_level_id: preference_level_id, date: current_date)
    end
  end
end


