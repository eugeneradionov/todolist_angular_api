class Comment < ApplicationRecord
  belongs_to :task, counter_cache: true
  validates :body, length: {maximum: 200}, presence: true
end
