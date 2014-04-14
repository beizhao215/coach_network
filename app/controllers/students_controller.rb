class StudentsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_student,   only: [:edit, :update]
  
  
  def new
    @student = Student.new
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def create
    @student = Student.new(student_params)    # Not the final implementation!
    if @student.save
      sign_in @student
      flash[:success] = "Welcome to the Coach Network!"
      redirect_to @student
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @student.update_attributes(student_params)
      flash[:success] = "Profile updated"
      redirect_to @student
    else
      render 'edit'
    end
  end
  
  private
  
  def student_params
    params.require(:student).permit(:name,:email,:password,:password_confirmation)
  end
  
  # Before filters

  
  
  def correct_student
    @student = Student.find(params[:id])
    redirect_to(root_path) unless current_student?(@student)
  end
end
