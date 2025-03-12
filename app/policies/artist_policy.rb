class ArtistPolicy < ApplicationPolicy

  def index?
    user.super_admin? || user.artist_manager?
  end

  def show?
    user.super_admin? || user.artist_manager?
  end

  def create?
    user.super_admin? || user.artist_manager?
  end

  def update?
    user.super_admin? ||  user.artist_manager?
  end

  def destroy?
    user.super_admin? || user.artist_manager?
  end

  def import?
    user.super_admin? || user.artist_manager?
  end

  def export?
    user.super_admin? || user.artist_manager?
  end
end
