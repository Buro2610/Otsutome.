class PreferenceLevel < ApplicationRecord
  # 名前が存在すること
  validates :name, presence: true, uniqueness: true
end
