class ShiftPreference < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  belongs_to :preference_level
end
