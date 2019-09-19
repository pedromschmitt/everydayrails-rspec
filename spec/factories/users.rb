FactoryBot.define do
  factory :user do
    first_name { "Pedro" }
    last_name { "Schmitt" }
    email { "tester@example.com" }
    password { "uncleiroh" }
  end
end
