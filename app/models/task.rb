class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  validates :name, presence: true, length: { maximum: 200 }
  acts_as_list scope: :project
end
