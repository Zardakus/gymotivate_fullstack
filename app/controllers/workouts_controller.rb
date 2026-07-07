class WorkoutsController < ApplicationController
  def index
    # Usando Eager Loading (includes) para matar o problema de N+1 queries
    @workouts = Workout.includes(:trainer, :member).all
    # O Pundit vai lá na WorkoutPolicy verificar o método index?
    authorize Workout
  end

  def new
    @workout = Workout.new
    # O Pundit vai barrar os alunos aqui antes mesmo da tela carregar
    authorize @workout
  end

  def create
    @workout = Workout.new(workout_params)
    authorize @workout

    if @workout.save
      redirect_to root_path, notice: "Ficha de treino criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  # O famoso Strong Parameters que vimos na Fase 2
  def workout_params
    params.require(:workout).permit(:name, :description, :trainer_id, :member_id)
  end
end
