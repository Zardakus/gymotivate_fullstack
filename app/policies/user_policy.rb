class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    # O Admin pode deletar, mas NÃO PODE deletar a si mesmo (evita suicídio digital e travamento do sistema)
    user.admin? && record.id != user.id
  end
end
