import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Define os alvos que declaramos no HTML com data-password-visibility-target
  static targets = [ "input", "icon" ]

  // A função que é chamada pelo data-action no clique do botão
  toggle() {
    if (this.inputTarget.type === "password") {
      // Muda para texto normal para revelar a senha
      this.inputTarget.type = "text"
      this.iconTarget.textContent = "Ocultar"
    } else {
      // Retorna para o tipo password para esconder a senha
      this.inputTarget.type = "password"
      this.iconTarget.textContent = "Mostrar"
    }
  }
}
