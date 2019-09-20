FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { "Pedro" }
    last_name { "Schmitt" }
    #each new user gets a unique, sequential email: address–tester1@example.com, tester2@example.com...
    sequence(:email) { |n| "tester#{n}@example.com"}
    password { "uncleiroh" }
  end
end
