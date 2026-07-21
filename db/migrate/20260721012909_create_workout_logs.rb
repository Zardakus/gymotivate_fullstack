class CreateWorkoutLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_logs do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: { to_table: :users }
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
