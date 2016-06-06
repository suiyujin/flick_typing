class ChangeColumnFromScoreToTotalTime < ActiveRecord::Migration
  def change
    remove_column :inputs, :score
    add_column :inputs, :total_time, :time, null: false
  end
end
