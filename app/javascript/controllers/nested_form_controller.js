import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Diz ao Stimulus quais elementos HTML ele deve observar
  static targets = ["target", "template"]

  add(event) {
    event.preventDefault() // Impede a página de rolar para o topo ao clicar no botão

    // Pega o HTML do template e substitui 'NEW_RECORD' por um timestamp único
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())

    // Cola o novo HTML no final da nossa lista de exercícios
    this.targetTarget.insertAdjacentHTML('beforeend', content)
  }
}
