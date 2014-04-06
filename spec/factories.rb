FactoryGirl.define do
  factory :coach do
    sequence(:name)  { |n| "Coach #{n}" }  
    sequence(:email) { |n| "coach_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
end