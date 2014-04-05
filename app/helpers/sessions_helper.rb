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
  
  def signed_in?
    !current_coach.nil?
  end
  
  def sign_out
    current_coach.update_attribute(:remember_token, Coach.hash(Coach.new_remember_token))
    self.current_coach = nil
    cookies.delete(:remember_token)
  end
end
