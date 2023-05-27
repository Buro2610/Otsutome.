class ShiftPreference < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  belongs_to :preference_level

  # バリデーションの前にset_date_from_start_timeを行い、セットしたい
  before_validation :set_date_from_start_time

  # ユーザー、タイムスロット、プレファレンスレベル、日付が存在すること
  validates :user_id, presence: true
  validates :time_slot_id, presence: true
  validates :preference_level_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :date, presence: true

  # 同じユーザーが同じ日に同じタイムスロットで2つ以上のシフト希望を持たないこと
  validates :user_id, uniqueness: { scope: [:time_slot_id, :start_time, :end_time] }


  private

  def set_date_from_start_time
    self.date = self.start_time.to_date
  end

end
