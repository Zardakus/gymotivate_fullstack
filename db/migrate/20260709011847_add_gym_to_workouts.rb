class AddGymToWorkouts < ActiveRecord::Migration[7.2]
  def change
    add_reference :workouts, :gym, null: false, foreign_key: true
  end
end
