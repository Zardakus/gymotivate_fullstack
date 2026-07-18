class ApplicationController < ActionController::Base
  include Pagy::Method

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Garante que o Devise bloqueie quem não estiver logado antes de qualquer coisa
  before_action :authenticate_user!

  # Diz para o Pundit olhar para o current_user do Devise
  include Pundit::Authorization

  # Intercepta erros de invasão do Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    # Adiciona uma mensagem de erro na tela e manda o usuário de volta de onde veio (ou para a home)
    flash[:alert] = "Você não tem permissão para realizar esta ação."
    redirect_back(fallback_location: root_path)
  end
end
