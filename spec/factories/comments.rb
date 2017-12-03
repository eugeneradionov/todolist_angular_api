FactoryBot.define do
  factory :comment do
    body { FFaker::Lorem.sentences }
    attachment 'Attachment base64 url'
    task
  end
end
