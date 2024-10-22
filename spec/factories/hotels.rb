FactoryBot.define do
  factory :hotel do
    display_name { "Hotel display name" }
    association :city
  end
end
