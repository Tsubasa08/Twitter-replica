FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    # sequence(:email) { |n| "tester#{n}@supplebox.jp"}
    email {'test@mail.com'}
    password {'password'}
    activated { true }
    admin { false }
  end
end