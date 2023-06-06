class Task < ApplicationRecord
  include RankedModel
  ranks :order



  belongs_to :user  # タスクはユーザーに所属？

  validates :name, length: { maximum: 8 },presence: true
  validates :order, presence: true

end
