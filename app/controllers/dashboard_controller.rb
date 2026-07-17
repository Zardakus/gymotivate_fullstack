class DashboardController < ApplicationController
  def index
    # Variável base da academia do usuário logado
    @gym = current_user.gym

    # 1. Agregações Simples (O banco executa: SELECT COUNT(*) FROM ...)
    @total_workouts = @gym.workouts.count
    @total_members = @gym.users.where(role: :member).count
    @total_trainers = @gym.users.where(role: :trainer).count

    # 2. Agregação Complexa (Relatório de Produtividade)
    # Junta a tabela de treinos com a tabela de usuários (professores),
    # agrupa pelo nome do professor e conta quantos treinos cada um montou.
    # Resultado esperado: Um Hash Ruby {"Rodrigo" => 5, "Claudia" => 2}
    @workouts_by_trainer = @gym.workouts
                               .joins(:trainer)
                               .group('users.name')
                               .count
  end
end
