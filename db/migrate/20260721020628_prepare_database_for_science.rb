class PrepareDatabaseForScience < ActiveRecord::Migration[7.2]
  def change
    # 1. Adicionar o Grupo Muscular no Molde (Ficha Base)
    add_column :exercises, :muscle_group, :string

    # 2. Deletar as colunas de texto antigas (Isso apagará o histórico dos testes de ontem)
    remove_column :exercise_logs, :actual_reps, :string
    remove_column :exercise_logs, :actual_weight, :string

    # 3. Recriar as colunas com os tipos numéricos exatos exigidos pelas fórmulas
    add_column :exercise_logs, :actual_sets, :integer
    add_column :exercise_logs, :actual_reps, :integer
    # Decimal com precision 5 e scale 2 permite salvar pesos como 150.50 kg
    add_column :exercise_logs, :actual_weight, :decimal, precision: 5, scale: 2
    add_column :exercise_logs, :rir, :integer
  end
end
