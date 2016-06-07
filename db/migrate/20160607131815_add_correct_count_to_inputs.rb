class AddCorrectCountToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :correct_count, :integer, null: false
  end
end
