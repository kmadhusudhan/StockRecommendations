class RolesController < ApplicationController
  def index
    @roles = Role.all.where.not(name: 'Admin')
   end

  def change_role
    role = Role.find(params[:role])
    session[:current_role] = role.name
    render json: { role: role }, status: :ok
   end
end
