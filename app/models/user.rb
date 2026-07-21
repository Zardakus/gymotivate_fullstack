class User < ApplicationRecord
  # Módulos padrão do Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :gym, optional: true

  # Como o nome da tabela é o mesmo (users), precisamos especificar a foreign_key
  has_many :workouts_as_trainer, class_name: 'Workout', foreign_key: 'trainer_id', dependent: :destroy
  has_many :workouts_as_member, class_name: 'Workout', foreign_key: 'member_id', dependent: :destroy

  has_many :workout_logs, foreign_key: 'member_id', dependent: :destroy

  # Nosso sistema de papéis
  enum role: { admin: 0, trainer: 1, member: 2 }
end
