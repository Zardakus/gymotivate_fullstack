class WorkoutsController < ApplicationController
# Executa o método set_workout para carregar a ficha antes de rodar as ações específicas
before_action :set_workout, only: [:edit, :update, :destroy]

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

  def edit
    authorize @workout
  end

  def update
    authorize @workout
    if @workout.update(workout_params)
      redirect_to root_path, notice: "Ficha de treino atualizada com sucesso!"
    else
      reder :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @workout
    @workout.destroy

    # Respondemos dizendo ao Rails para procurar um arquivo de fluxo ou rodar inline
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Treino removido." }
      # Se a requisição for do Turbo, ele executa essa linha:
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@workout))}
    end
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :description, :trainer_id, :member_id)
  end
end
