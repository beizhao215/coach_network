class CoachesController < ApplicationController
  def new
    @coach = Coach.new
  end
  
  def show
    @coach = Coach.find(params[:id])
  end
  
  def create
    @coach = Coach.new(coach_params)    
    if @coach.save
      flash[:success] = "Welcome to the Coach Network!"
      redirect_to @coach
    else
      render 'new'
    end
  end
  
  private

      def coach_params
        params.require(:coach).permit(:name, :email, :password,
                                     :password_confirmation)
      end
end
