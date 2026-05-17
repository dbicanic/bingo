class CreateBingoCards < ActiveRecord::Migration[8.1]
  def change
    create_table :bingo_cards do |t|
      t.references :game, null: false, foreign_key: true
      t.jsonb :grid, null: false
      t.string :label

      t.timestamps
    end
  end
end
