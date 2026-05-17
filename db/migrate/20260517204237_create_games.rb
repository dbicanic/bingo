class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.integer :drawn_numbers, array: true, default: []
      t.string :status, null: false, default: "active"

      t.timestamps
    end
  end
end
