class UserPolicy < ApplicationPolicy

  def index?
    user.super_admin?
  end
  # Define if an artist can be shown
  def show?
    user.super_admin?
  end

  # Define if an artist can be created
  def create?
    user.super_admin?
  end

  # Define if an artist can be updated
  def update?
    user.super_admin?
  end

  # Define if an artist can be destroyed
  def destroy?
    user.super_admin?
  end
end
