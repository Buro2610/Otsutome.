class Task < ApplicationRecord
  belongs_to :user  # 一つのタスクは一人のユーザーに所属する
end
