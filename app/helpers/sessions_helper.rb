module SessionsHelper
  def sign_in(coach)
    remember_token = Coach.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    coach.update_attribute(:remember_token, Coach.hash(remember_token))
    self.current_coach = coach
  end
  
  def current_coach=(coach)
    @current_coach = coach
  end
  
  def current_coach
    remember_token = Coach.hash(cookies[:remember_token])
    @current_coach ||= Coach.find_by(remember_token: remember_token)
  end
  
  def current_coach?(coach)
    coach == current_coach
  end
  
  def signed_in?
    !current_coach.nil?
  end
  
  def sign_out
    current_coach.update_attribute(:remember_token, Coach.hash(Coach.new_remember_token))
    self.current_coach = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end
end
