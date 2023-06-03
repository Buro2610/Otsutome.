class PreferenceLevel < ApplicationRecord
  has_many :shift_preferences, dependent: :destroy
  belongs_to :color
  # 名前が存在すること
  validates :name, presence: true, uniqueness: true
  validates :color_id, presence: true

  # 並び順order列に基づく(昇順)
  default_scope { order(order: :asc) }

end
