class TimeSlot < ApplicationRecord
  include RankedModel
  ranks :order

  has_many :shift_preferences, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :order, presence: true

  validate :start_time_before_end_time

  private

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:start_time, "can't be greater than or equal to end time")
    end
  end
end
