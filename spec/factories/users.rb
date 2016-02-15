FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "MyPassword"
    password_confirmation "MyPassword"
    first_name "Anh"
    last_name "Nguyen"
  end

  trait :short_password do
      password "short"
      password_confirmation "short"
  end

  trait :wrong_password_confirmation do
      password "firstpassword"
      password_confirmation "secondpassword"
  end

  trait :no_password do
      password nil
  end
end
