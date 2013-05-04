class RemoveBaseFromText < ActiveRecord::Migration
  def up
    remove_column :texts, :base_id
  end

  def down
    add_column :texts, :base_id, :integer
    add_index :texts, :base_id
  end
end
