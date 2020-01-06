class DashboardsController < ApplicationController
  def index
    @recommendations = Recommendation.includes(:stock).all
   end
end
