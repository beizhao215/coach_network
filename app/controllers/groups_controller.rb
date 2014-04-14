class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]

  def index
  end

  def new
  end
  
  def create
  end

  def destroy
  end
end