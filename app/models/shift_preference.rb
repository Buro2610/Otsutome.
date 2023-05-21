class ShiftPreference < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  belongs_to :preference_level

  # ユーザー、タイムスロット、プレファレンスレベル、日付が存在すること
  validates :user_id, presence: true
  validates :time_slot_id, presence: true
  validates :preference_level_id, presence: true
  validates :datetime, presence: true

  # 同じユーザーが同じ日に同じタイムスロットで2つ以上のシフト希望を持たないこと
  validates :user_id, uniqueness: { scope: [:time_slot_id, :datetime] }
end
