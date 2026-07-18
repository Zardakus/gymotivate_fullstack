class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:edit, :update, :destroy]

  def index
    # 1. Prepara a base (Sem rodar o SQL ainda) ordenada pelos mais recentes
    base_query =  current_user.gym.workouts.includes(:trainer, :member, :exercises).order(created_at: :desc)

    # 2. Se o usuário digitou algo na busca, adicionamos o filtro WHERE ILIKE (PostgreSQL)
    if params[:query].present?
      base_query = base_query.where("workouts.title ILIKE :search OR workouts.description ILIKE :search", search: "%#{params[:query]}%")
    end

    # 3. O Pagy assume o controle: Ele conta o total, aplica LIMIT e OFFSET e dispara o SQL no banco
    @pagy, @workouts = pagy(base_query)
    authorize Workout
  end

  def new
    # 2. Já cria um treino em memória associado à academia correta
    @workout = current_user.gym.workouts.build
    # Cria 3 espaços vazios na memória para o formulário renderizar os campos
    3.times { @workout.exercises.build }
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
    params.require(:workout).permit(
      :title,
      :description,
      :trainer_id,
      :member_id,
      exercises_attributes: [:id, :name, :sets, :reps, :_destroy]
    )
  end
end
