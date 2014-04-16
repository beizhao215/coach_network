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
    
    
    students = Student.all
    n = 1
    students.each do |student|
      group = Group.find_by(id:n)
      student.enroll!(group)
      n = n+1
    end
    
    groups = Group.all
    groups.each do |group|
      content = Faker::Lorem.sentence(5)
      group.posts.create!(content: content, coach_id: group.coach.id)
      if group.enrollments.any?
        group.enrollments.each do |enrollment|
          group.posts.create!(content: content, student_id: enrollment.student.id)
        end
      end
    end
  end
end