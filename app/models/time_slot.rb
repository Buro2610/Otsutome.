class TimeSlot < ApplicationRecord
  # 名前が存在すること
  has_many :shift_preferences, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  # 開始時間と終了時間が存在すること
  validates :start_time, presence: true
  validates :end_time, presence: true

  # 開始時間が終了時間よりも前であること
  validate :start_time_before_end_time

  # 並び順order列に基づく(昇順)
  default_scope { order(order: :asc) }

  private

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:start_time, "can't be greater than or equal to end time")
    end
  end
end
