class SessionsController < ApplicationController
  def new
  end

  def create
    coach = Coach.find_by(email: params[:session][:email].downcase)
    student = Student.find_by(email: params[:session][:email].downcase)
    if coach && coach.authenticate(params[:session][:password])
      sign_in coach
      redirect_back_or coach
    elsif student && student.authenticate(params[:session][:password])
      sign_in student
      redirect_back_or student
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end  
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
