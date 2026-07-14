class Workout < ApplicationRecord
  belongs_to :gym
  belongs_to :trainer, class_name: 'User'
  belongs_to :member, class_name: 'User'

# 1. Define a relação 1:N (Se apagar o treino, apaga os exercícios)
  has_many :exercises, dependent: :destroy

  # 2. Habilita o formulário aninhado
  # allow_destroy: true -> Permite deletar um exercício diretamente pela tela de edição do treino
  # reject_if: :all_blank -> Se o usuário deixar os campos do exercício em branco, o sistema ignora em vez de dar erro
  accepts_nested_attributes_for :exercises, allow_destroy: true, reject_if: :all_blank
end
