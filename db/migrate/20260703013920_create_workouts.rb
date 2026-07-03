class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.string :title
      t.text :description

      t.references :trainer, null: false, foreign_key: { to_table: :users }
      t.references :member, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
