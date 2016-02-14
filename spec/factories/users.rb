FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "MyPassword"
    first_name "Anh"
    last_name "Nguyen"
  end

  trait :short_password do
      password "short"
  end

  trait :wrong_password_confirmation do
      password "firstpassword"
  end

  trait :no_password do
      password nil
  end
end
