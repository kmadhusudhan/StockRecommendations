class RecommendationsController < ApplicationController
  before_action :set_recommendation, only: %i[show edit update destroy vote]

  # GET /recommendations
  # GET /recommendations.json
  def index
    @recommendations = Recommendation.includes(:stock).all
  end

  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    @recommendation
  end

  # GET /recommendations/new
  def new
    @recommendation = Recommendation.new
    authorize @recommendation
  end

  # GET /recommendations/1/edit
  def edit
    authorize @recommendation
  end

  # POST /recommendations
  # POST /recommendations.json
  def create
    authorize Recommendation
    @recommendation = Recommendation.new(recommendation_params)
    @web_push_notification = WebPushNotification.new(title: @recommendation.title, body: @recommendation.description)
    respond_to do |format|
      if @recommendation.save && @web_push_notification.save
        format.html { redirect_to @recommendation, notice: 'Recommendation was successfully created.' }
        format.json { render :show, status: :created, location: @recommendation }
      else
        format.html { render :new }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommendations/1
  # PATCH/PUT /recommendations/1.json
  def update
    authorize @recommendation
    respond_to do |format|
      if @recommendation.update(recommendation_params)
        format.html { redirect_to @recommendation, notice: 'Recommendation was successfully updated.' }
        format.json { render :show, status: :ok, location: @recommendation }
      else
        format.html { render :edit }
        format.json { render json: @recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendations/1
  # DELETE /recommendations/1.json
  def destroy
    authorize @recommendation
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to recommendations_url, notice: 'Recommendation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    @recommendation.liked_by current_user
    render json: { recommendation: @recommendation, votes: @recommendation.votes_for.size }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recommendation_params
    params.require(:recommendation).permit(:title, :description, :stock_id)
  end
end
