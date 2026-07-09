class Gym < ApplicationRecord
  has_many :users
  has_many :workouts, dependent: :destroy
end
