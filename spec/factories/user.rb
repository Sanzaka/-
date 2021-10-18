FactoryBot.define do
  factory :user do
    name {Faker::JapaneseMedia::StudioGhibli.unique.character}
    email {Faker::Internet.email}
    password {"password"}
    password_confirmation {"password"}
  end
end