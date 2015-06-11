require 'pry'
@post
class PostsController < ApplicationController
  before_action :signed_in_user
  
  def new
    @post = Post.new(parent_id: params[:parent_id])
  end

  def create
   # binding.pry
    
    if params[:post][:parent_id].to_i > 0
      parent = Post.find_by_id(params[:post].delete(:parent_id))
     # binding.pry
      
      if student_signed_in?
        @post = parent.children.create(content:params[:post][:content],student_id:current_student.id, group_id: $current_group.id)  
      elsif coach_signed_in?
        @post = parent.children.create(content:params[:post][:content],coach_id:current_coach.id, group_id: $current_group.id)
      end
     #binding.pry
      
    else
      if student_signed_in?
        @post = $current_group.posts.create(content:params[:post][:content],student_id:current_student.id)  
      elsif coach_signed_in?
        @post = $current_group.posts.create(content:params[:post][:content],coach_id:current_coach.id)
      end
    end
    if @post.save  
      flash[:success] = "Post created!"
      redirect_to group_path($current_group)
    else
      flash[:error] = "Post length not correct!"
      #binding.pry
      redirect_to group_path($current_group)
    end
  end
  

end