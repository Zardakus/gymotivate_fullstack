class WorkoutPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  # Quem pode ver a lista de treinos? Todo mundo logado.
  def index?
    true
  end

  # Quem pode ver uma ficha específica? Todo mundo logado.
  def show?
    record.gym_id == user.gym_id
  end

  # Quem pode criar? Admins ou Professores.
  def create?
    user.admin? || user.trainer?
  end

  def new?
    create?
  end

  # Quem pode atualizar? Admins OU o Professor dono daquela ficha específica.
  def update?
    user.admin? || (user.trainer? && record.trainer_id == user.id)
  end

  def edit?
    update?
  end

  # Quem pode apagar? Apenas Admins.
  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
