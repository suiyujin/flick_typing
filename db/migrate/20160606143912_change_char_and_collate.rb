class ChangeCharAndCollate < ActiveRecord::Migration
  def up
    execute "ALTER TABLE inputs MODIFY COLUMN text TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL;"
    execute "ALTER TABLE answers MODIFY COLUMN text TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL;"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
