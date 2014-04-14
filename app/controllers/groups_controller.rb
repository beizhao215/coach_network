class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index
  end

  def new
    @group = current_coach.groups.build
  end
  
  def create
    @group = current_coach.groups.build(group_params)
    if @group.save
      flash[:success] = "Group created!"
      redirect_to current_coach
    else
      render 'new'
    end
  end
  
  def show
    @group = Group.find(params[:id])
    
  end

  def destroy
  end
  
  private
  
      def group_params
        params.require(:group).permit(:name,:description)
      end
      
end