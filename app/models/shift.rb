class Shift < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :otsutome_title, presence: true, length: { maximum: 140 }
end
