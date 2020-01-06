class RecommendationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    session[:current_role] == 'Analyst' || user.is_admin?
  end

  def update?
    session[:current_role] == 'Analyst' || user.is_admin?
  end

  def create?
    session[:current_role] == 'Analyst' || user.is_admin?
  end

  def destroy?
    session[:current_role] == 'Analyst' || user.is_admin?
  end
end
