class Comment < ApplicationRecord
  belongs_to :task

  validates :name, presence: true, length: { maximum: 10 }
  validates :comment, presence: true, length: { maximum: 1000 }
end
