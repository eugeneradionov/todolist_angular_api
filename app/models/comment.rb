class Comment < ApplicationRecord
  self.record_timestamps = true
  belongs_to :task, counter_cache: true
  validates :body, length: { in: 10..256 }, presence: true
  mount_base64_uploader :attachment, AttachmentUploader
end
