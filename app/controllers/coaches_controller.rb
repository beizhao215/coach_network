class CoachesController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_coach,   only: [:edit, :update]
  before_action :admin_coach,     only: :destroy
  
  
  def index
    @coaches = Coach.paginate(page: params[:page])
  end
  
  def new
    @coach = Coach.new
  end
  
  def show
    @coach = Coach.find(params[:id])
    @groups = @coach.groups
    $showed_coach = @coach
  end
  
  def create
    @coach = Coach.new(coach_params)    
    if @coach.save
      sign_in @coach
      flash[:success] = "Welcome to the Coach Network!"
      redirect_to @coach
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @coach = Coach.find(params[:id])
    if @coach.update_attributes(coach_params)
      flash[:success] = "Profile updated"
      redirect_to @coach    
    else
      render 'edit'
    end
  end
  
  def destroy
    Coach.find(params[:id]).destroy
    flash[:success] = "Coach destroyed"
    redirect_to coaches_url
  end
  
  private

      def coach_params
        params.require(:coach).permit(:name, :email, :password,
                                     :password_confirmation, :phone, :subject, :location,
                                     :self_introduction, :course_introduction)
      end
      
      # Before filters

      
      
      def correct_coach
        @coach = Coach.find(params[:id])
        redirect_to(root_path) unless current_coach?(@coach)
      end
      
      def admin_coach
        redirect_to(root_path) unless current_coach.admin?
      end
end
