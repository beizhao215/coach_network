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
  
  factory :student do
    sequence(:name)  { |n| "Student #{n}" }  
    sequence(:email) { |n| "student_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :group do
    name "Tennis"
    description "Test group"
    coach
  end
  
  factory :post do
    content "Lorem ipsum"
    coach
    group
  end
  
  factory :message do
    title "message title"
    content "Lorem ipsum"
    student
    coach
  end
end