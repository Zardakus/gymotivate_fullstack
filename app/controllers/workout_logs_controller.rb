class WorkoutLogsController < ApplicationController
  def new
    # 1. Encontramos a Ficha Base (Molde) que o aluno escolheu
    @workout = current_user.gym.workouts.find(params[:workout_id])

    # 2. Iniciamos um Log de Treino na memória, marcando a hora de início
    @workout_log = WorkoutLog.new(workout: @workout, member: current_user, started_at: Time.current)
    authorize @workout_log

    # 3. A Mágica do Builder: Para cada exercício do molde, criamos uma "linha de resposta" vazia no Log
    @workout.exercises.each do |exercise|
      @workout_log.exercise_logs.build(exercise: exercise)
    end
  end

  def create
    @workout_log = WorkoutLog.new(workout_log_params)
    @workout_log.member = current_user
    @workout_log.completed_at = Time.current

    authorize @workout_log

    if @workout_log.save
      redirect_to root_path, notice: 'Treino finalizado e salvo no seu histórico!'
    else
      # Se der erro de validação, precisamos recarregar o molde para a tela não quebrar
      @workout = @workout_log.workout
      render :new, status: :unprocessable_entity
    end
  end

  private

  def workout_log_params
    # O pacotão (Nested Attributes) agora carrega as respostas dos exercícios
    params.require(:workout_log).permit(
      :workout_id,
      exercise_logs_attributes: [:exercise_id, :actual_reps, :actual_weight, :completed]
    )
  end
end
