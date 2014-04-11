module SessionsHelper
  def sign_in(coach)
    remember_token = Coach.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    coach.update_attribute(:remember_token, Coach.hash(remember_token))
    self.current_coach = coach
  end
  
  def sign_in(student)
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    student.update_attribute(:remember_token, Student.hash(remember_token))
    self.current_student = student
  end
  
  def current_coach=(coach)
    @current_coach = coach
  end
  
  def current_student=(student)
    @current_student = student
  end
  
  def current_coach
    remember_token = Coach.hash(cookies[:remember_token])
    @current_coach ||= Coach.find_by(remember_token: remember_token)
  end
  
  def current_student
    remember_token = Student.hash(cookies[:remember_token])
    @current_student ||= Student.find_by(remember_token: remember_token)
  end
  
  def current_coach?(coach)
    coach == current_coach
  end
  
  def current_student?(student)
    student == current_student
  end
  
  def coach_signed_in?
    !current_coach.nil?
  end
  
  def student_signed_in?
    !current_student.nil?
  end
  
  def signed_in?
    coach_signed_in? || student_signed_in?
  end
  
  def sign_out
    if coach_signed_in?
      current_coach.update_attribute(:remember_token, Coach.hash(Coach.new_remember_token))
      self.current_coach = nil
      cookies.delete(:remember_token)
    end
    if student_signed_in?
      current_student.update_attribute(:remember_token, Student.hash(Coach.new_remember_token))
      self.current_student = nil
      cookies.delete(:remember_token)
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end
end
