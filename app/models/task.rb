class Task < ApplicationRecord
  belongs_to :user  # タスクはユーザーに所属？

  validates :name, length: { maximum: 8 },presence: true
end
