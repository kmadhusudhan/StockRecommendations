class StocksController < ApplicationController
  before_action :set_stock, only: %i[show edit update destroy follow unfollow]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
    authorize @stocks
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    authorize @stock
  end

  # GET /stocks/new
  def new
    authorize Stock
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
    authorize @stock
  end

  # POST /stocks
  # POST /stocks.json
  def create
    authorize Stock
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    authorize @stock
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    authorize @stock
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    Follow.create(follower_id: current_user.id, following_id: @stock.id)
    render json: { stock: @stock, follow_count: @stock.followers.count }, status: :ok
  end

  # def unfollow
  #   @stock.following_relationships.find_by(following_id: current_user.id).destroy
  #   render json: { stock: @stock, follow_count: @stock.followers.count }, status: :ok
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    @stock = Stock.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def stock_params
    params.require(:stock).permit(:title, :sector, :description)
  end
end
