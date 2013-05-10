class AddRepositoryToModification < ActiveRecord::Migration
  def change
    add_column :modifications, :repository_id, :integer
    add_index :modifications, :repository_id
  end
end
