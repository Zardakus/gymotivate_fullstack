class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    # Busca todos os usuários DAQUELA ACADEMIA, ordenados pelos mais recentes
    @users = current_user.gym.users.order(created_at: :desc)
    authorize User
  end

  def new
    @user = current_user.gym.users.build
    authorize @user
  end

  def create
    @user = current_user.gym.users.build(user_params)
    authorize @user

    if @user.save
      redirect_to users_path, notice: 'Usuário cadastrado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Se o admin deixou a senha em branco na edição, nós ignoramos o campo para não dar erro
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuário atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'Usuário removido da academia.'
  end

  private

  def set_user
    @user = current_user.gym.users.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
