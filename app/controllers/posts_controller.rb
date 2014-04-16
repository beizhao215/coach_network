class PostsController < ApplicationController
  before_action :signed_in_user
  

  def create
    if student_signed_in?
      @post = $current_group.posts.create(content:params[:post][:content],student_id:current_student.id)  
    elsif coach_signed_in?
      @post = $current_group.posts.create(content:params[:post][:content],coach_id:current_coach.id)  
    end
    if @post.save  
      flash[:success] = "Post created!"
      redirect_to group_path($current_group)
    else
      flash[:error] = "Post length not correct!"
      
      redirect_to group_path($current_group)
    end
  end
  

end