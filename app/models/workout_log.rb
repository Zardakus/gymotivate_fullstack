class WorkoutLog < ApplicationRecord
  belongs_to :workout
  belongs_to :member, class_name: 'User'

  has_many :exercise_logs, dependent: :destroy
  # Habilita salvar os exercícios junto com o log do treino
  accepts_nested_attributes_for :exercise_logs
end
