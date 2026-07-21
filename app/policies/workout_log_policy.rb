class WorkoutLogPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  class Scope < ApplicationPolicy::Scope
  end
end
