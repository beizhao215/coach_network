class EmailsController < ApplicationController
  before_action :correct_coach,   only: [:new, :create]
  
  
  def new
    @email = Email.new
  end
  
  def create
    @email = Email.new(email_params)
    if @email.save
      CoachMailer.group_email(@email).deliver
      redirect_to group_path($current_group), notice: "Emails sent successfully"
    else
      render :new
    end
  end
  
  private 
      
    def email_params
      params.require(:email).permit(:title, :content)
    end
    
    def correct_coach
      if $current_group.nil?
        redirect_to(root_path)
      end
      if coach_signed_in?
        redirect_to(root_path) unless $current_group.coach.id == current_coach.id
      else
        redirect_to(root_path)
      end
    end
    
end