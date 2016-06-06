class AddPenaltyCountToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :penalty_count, :integer, null: false
  end
end
