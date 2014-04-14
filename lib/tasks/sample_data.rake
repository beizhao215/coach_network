namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Coach.create!(name: "Example Coach",
                 email: "coach@coachnetwork.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true )
    99.times do |n|
      name  = Faker::Name.name
      email = "coach-#{n+1}@coachnetwork.com"
      password  = "password"
      @coach = Coach.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      course_name = "Course #{n+1}"
      description = "Description #{n+1}"
      Group.create!(name: course_name,
                    description: description,
                    coach_id: @coach.id)
    end
    
    99.times do |n|
      name  = Faker::Name.name
      email = "student-#{n+1}@coachnetwork.com"
      password  = "password"
      Student.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end