class AddHeadTextToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :head_text, :string, null: false
  end
end
