class Api::V1::GroupsController < Api::V1::BaseController
  def index
    respond_with(Group.all)
  end
end