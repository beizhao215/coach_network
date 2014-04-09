class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def create
    @student = Student.new(student_params)    # Not the final implementation!
    if @student.save
      flash[:success] = "Welcome to the Coach Network!"
      redirect_to @student
    else
      render 'new'
    end
  end
  
  private
  
  def student_params
    params.require(:student).permit(:name,:email,:password,:password_confirmation)
  end
end
