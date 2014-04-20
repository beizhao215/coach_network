class Api::V1::CoachesController < Api::V1::BaseController
  def index
    respond_with(Coach.all)
  end
end