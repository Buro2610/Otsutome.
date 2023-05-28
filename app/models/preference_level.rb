class PreferenceLevel < ApplicationRecord
  has_many :shift_preferences, dependent: :destroy
  belongs_to :color
  # 名前が存在すること
  validates :name, presence: true, uniqueness: true
  validates :color_id, presence: true
end
