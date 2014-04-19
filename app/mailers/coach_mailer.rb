class CoachMailer < ActionMailer::Base
  default from: "coach.networkemail@gmail.com"

  
  def group_email(email)
    @email = email
    addresses = Array.new
    $current_group.enrollments.each do |enrollment|
      @addr = enrollment.student.email
      addresses<<@addr
    end
    mail to: addresses, subject: "#{$current_group.name}: #{@email.title}"
    #mail to: $current_group.enrollments.first.student.email, subject: "#{$current_group.name}: #{@email.title}"
  end
end
