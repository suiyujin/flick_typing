class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.text :text
      t.float :score
      t.time :time
      t.references :team, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
