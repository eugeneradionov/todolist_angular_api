FactoryBot.define do
  factory :task do
    name { FFaker::HipsterIpsum.word }
    deadline { Time.zone.tomorrow }
    completed false
    project
  end
end
