class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /app_users
  # GET /app_users.json
  def index
    @users = User.all
    authorize @users
  end

  # GET /app_users/1
  # GET /app_users/1.json
  def show
    authorize @user
  end

  # GET /app_users/new
  def new
    authorize User
    @user = User.new
  end

  # GET /app_users/1/edit
  def edit
    authorize @user
  end

  # POST /app_users
  # POST /app_users.json
  def create
    authorize User
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'App user was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_users/1
  # PATCH/PUT /app_users/1.json
  def update
    authorize User
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_users/1
  # DELETE /app_users/1.json
  def destroy
    authorize User
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    if params[:user].present?
      params.require(:user).permit(:name, :dob, :email, :gender)
    elsif params[:male].present?
      params.require(:male).permit(:name, :dob, :email, :gender)
    else
      params.require(:female).permit(:name, :dob, :email, :gender)
    end
  end
end
