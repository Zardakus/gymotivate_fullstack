class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:edit, :update, :destroy]

  def index
    # 1. Vazamento resolvido: Lista apenas os treinos da academia do usuário logado
    @workouts = current_user.gym.workouts.includes(:trainer, :member)
    authorize Workout
  end

  def new
    # 2. Já cria um treino em memória associado à academia correta
    @workout = current_user.gym.workouts.build
    authorize @workout
  end

  def create
    # 3. O servidor (e não o HTML) injeta de forma segura o gym_id no novo treino
    @workout = current_user.gym.workouts.build(workout_params)
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
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @workout
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Treino removido." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@workout)) }
    end
  end

  private

  def set_workout
    # 4. Falha IDOR resolvida: Tenta encontrar o ID do treino APENAS dentro da academia do usuário!
    # Se ele tentar acessar o ID de um treino de outra academia, o Rails lança um erro 404 (RecordNotFound)
    @workout = current_user.gym.workouts.find(params[:id])
  end

  def workout_params
    # Note que NÃO permitimos o :gym_id aqui. O usuário jamais pode escolher ou forjar a academia no HTML.
    params.require(:workout).permit(:title, :description, :trainer_id, :member_id)
  end
end
