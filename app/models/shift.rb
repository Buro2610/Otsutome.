class Shift < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :otsutome_title, presence: true, length: { maximum: 140 }
  validate :start_time_before_end_time


  private

  def start_time_before_end_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "エラー :開始時間は終了時間より前に設定してください！")
    end
  end
end
