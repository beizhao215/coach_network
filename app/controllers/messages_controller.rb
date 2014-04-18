class MessagesController < ApplicationController
  
  def index
    @messages = Message.find_all_by_coach_id(current_coach.id)
  end
  
  def new
    @message = Message.new
    
  end
  
  def create
    @message = current_student.messages.create(title:params[:message][:title], content:params[:message][:content], coach_id: $showed_coach.id)   
    if @message.save
      flash[:success] = "Message sent!"
      redirect_to coach_path($showed_coach)
    else
      render new_message_path
    end
  end

  
end