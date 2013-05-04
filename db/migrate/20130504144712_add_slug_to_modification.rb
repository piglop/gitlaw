class AddSlugToModification < ActiveRecord::Migration
  def change
    add_column :modifications, :slug, :string
    add_index :modifications, :slug
  end
end
