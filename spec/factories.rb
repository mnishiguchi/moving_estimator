FactoryGirl.define do
  factory :user do
    username     "Masatoshi Nishiguchi"
    email        "mnishiguchi@example.com"
    password     "password"
    admin        false
    confirmed_at Time.now
  end
end
