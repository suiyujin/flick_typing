class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.text :text, null: false
      t.float :score, null: false
      t.time :time, null: false
      t.references :team, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
