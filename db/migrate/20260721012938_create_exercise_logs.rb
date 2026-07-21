class CreateExerciseLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :exercise_logs do |t|
      t.references :workout_log, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.string :actual_reps
      t.string :actual_weight
      t.boolean :completed

      t.timestamps
    end
  end
end
