FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'qwertyQ2' }
  end
end
