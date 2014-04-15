class EnrollmentsController < ApplicationController
  before_action :signed_in_user

  def create
    @group = Group.find(params[:enrollment][:group_id])
    current_student.enroll!(@group)
    redirect_to student_path(current_student)
  end

  def destroy
    @group = Enrollment.find(params[:id]).group
    current_student.drop!(@group)
    redirect_to student_path(current_student)
  end
end