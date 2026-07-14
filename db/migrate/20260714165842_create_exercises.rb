class CreateExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :sets
      t.string :reps
      t.string :weight
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
