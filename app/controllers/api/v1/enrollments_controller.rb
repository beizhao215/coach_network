class Api::V1::EnrollmentsController < Api::V1::BaseController
  
  
  def create
    enrollment = Enrollment.new(enrollment_params)
    if enrollment.save
      respond_with(enrollment, :location => api_v1_enrollment_path(enrollment))
    else
      respond_with(enrollment)
    end
  end
  
  private
   
  def enrollment_params
    params.require(:enrollment).permit(:student_id, :group_id)
  end
end